---
layout: post
title: Eclipse中无法使用java.io.Console
slug: java-io-console-error-in-eclipse
date: 2011-06-13 13:34
tags: [eclipse, java]
---

在 eclipse 中写一个 java 小程序，用到了 [Console][1] ，结果在运行时报空指针，但是在命令行里面运行却正常。

    package g2w.playground.console;

    import java.io.Console;

    public class ConsoleLogin {
        private static String USERNAME = "greatghoul";
        private static String PASSWORD = "mypass";

        public static void main(String[] args) {
            Console console = System.console();

            String username = console.readLine("username: ");
            String password = new String(console.readPassword("password: "));

            if (USERNAME.equals(username) &amp;&amp; PASSWORD.equals(password)) {
                console.printf("Hi, there! Dear %s.", username);
            } else {
                console.printf("Invalid username or password.");
            }
        }

    }

Java API 中 写道

> Whether a virtual machine has a console is dependent upon the underlying platform and also upon the manner in which 
> the virtual machine is invoked. If the virtual machine is started from an interactive command line without 
> redirecting the standard input and output streams then its console will exist and will typically be connected to 
> the keyboard and display from which the virtual machine was launched. If the virtual machine is started 
> automatically, for example by a background job scheduler, then it will typically not have a console.
> 
> If this virtual machine has a console then it is represented by a unique instance of this class which can be 
> obtained by invoking the System.console() method. If no console device is available then an invocation of that 
> method will return null.

看来是用不了，得用 Scanner 才行。

via: <http://www.codeguru.com/forum/showthread.php?t=487190>

[1]: http://download.oracle.com/javase/6/docs/api/java/io/Console.html
