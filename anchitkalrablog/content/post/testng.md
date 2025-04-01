---
title: "Developing Test Framework With Selenium and Test-NG"
date: 2015-10-18T22:00:23-08:00
Description: "Test-NG"
Tags: [automation, testing]
Categories: [development]
DisableComments: false
---


Initially, I had started out by writing some basic unit tests for my PHP application. Although these types of tests give you depth, they offer very little breath in terms of test coverage. I needed a solution which would test multiple features but required lesser code as compared to Unit test cases. User Acceptance Tests (UATs) seemed to be the best choice. IMHO, UATs also help in finding regressions in an application fairly quickly. Since I have been working on adding new features in my app this would also help me keep regression issues in check. And so I started looking around for information on how to design and develop basic user acceptance tests for a Web-app\Webpage.

There seems to be consensus on developing a framework while developing your test cases. Getting a framework helps you achieve couple of things ( Things which I have experienced):

    - They help add a layer of abstraction to your tests.
    - They hide the complexity from test cases.
    - Test suits are easier to maintain.
    - Help reduce the time from lengthy and tedious manual regressions

The easiest way I found for developing a test framework is by creating simple Smoke tests and then moving the complexity into the framework. I have tried to explain the process below.

### Web Site To Be Tested:

I will be writing test cases for a Web App we use for provisioning Virtual Machines for testing Xen Desktop. Some of the basic features which need to be tested are as follows:

    - Login In to the web application.
    - Provision a virtual machine providing a VM name, type and hypervisor to be used.
    - Delete a VM from a list of provisioned VMs.

 

### Smoke Test Case 1 – Login – LoginTests.java

Let’s start by noting down some of the steps I would need to do before I can assert the results.

Step-1: I would need to go to the Login Page.

Step-2: Enter Login and Password.

Step-3: Check if I am at the Dashboard page.

Now to keep the tests readable and easy to understand we would want to keep the wording similar to the above steps.

The following is what I came up with:

    @Test
    public void Admin_User_Can_Login()
    {
    LoginPage.GoTo();

    LoginPage.LoginAs("UserName").WithPassword("Password").Login();

    Assert.assertTrue("Failed to Login", DashboardPage.IsAt.get());

    }


The daisy chaining of code LoginAs(“user”).WithPassword(“password”) helps the reader to understand the test quickly. And the complexity associated with these is hidden in the framework.

#### Framework Classes:

###### LoginPage.java


    public class LoginPage {

    public static void GoTo()
    {

    OneLabWebDriver.Instance().get("http://FTLOnelab.citrite.net");

    }

    public static LoginCommand LoginAs(String userName)
    {
    return new LoginCommand(userName);

    }

    }

     

###### LoginCommand.java


    public class LoginCommand
    {
        private String userName;
        private String password;

        /**
        * sets the userName for the calling object
        *
        * @param _userName
        */
        public LoginCommand(String _userName)
        {
            this.userName = _userName;
        }

        /**
        * Sets the password and return the object
        *
        * @param _password
        * @return
        */
        public LoginCommand WithPassword(String _password)
        {
            this.password = _password;
            return this;
        }

        public void Login()
        {
            WebDriverWait wait = new WebDriverWait(OneLabWebDriver.Instance(),10);
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.name("passwd")));

            WebElement userNameElement = OneLabWebDriver.Instance().findElement(By.id("Enter user name"));
            userNameElement.sendKeys(userName);

            WebElement passwordElement = OneLabWebDriver.Instance().findElement(By.name("passwd"));
            passwordElement.sendKeys(password);

            WebElement logOn = OneLabWebDriver.Instance().findElement(By.id("Log_On"));
            logOn.click();

            OneLabWebDriver.Instance().switchTo().alert().accept();
            //wait for login
            wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("DG_updateworkspace")));
        }
    }

##### Ref:
##### - http://www.pluralsight.com/courses/automated-testing-framework-selenium
##### - [Creating Automation Framework From Scratch](https://www.youtube.com/watch?v=yPtnml4tNII)
