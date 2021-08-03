# Pearl sms library to send sms with http/rest/json

This Pearl sms library enables you to **send**, **receive**,**mark** and **delete** messsages from Pearl with http requests. 
The library uses HTTP Post requests and JSON encoded content to send the text
messages to the mobile network. It connects to the HTTP SMS API of 
[Ozeki SMS gateway](https://ozeki-sms-gateway.com). This repository is better
for implementing SMS solutions then other alternatives, because it allows
you to use the same code to send SMS through an Android mobile, through
a high performance IP SMS connection or a GSM modem or modem pool. This
library gives you SMS service provider independence.

## What is Ozeki SMS Gateway 
The Ozeki SMS Gateway is a powerful and very realiable gateway software that offers an HTTP API, allowing you to connect to it remotely. It can handle up to 1000 SMS per second with ease. It runs on your own environment so your data and contact list is safe. It also allows you to track your SMS traffic to manage your costs. It can be installed on Windows, Linux or even an android device, offering full service provider independence.

Download: [Ozeki SMS Gateway download page](https://ozeki-sms-gateway.com/p_727-download-sms-gateway.html)

Tutorial: [How to send sms from Perl](https://ozeki-sms-gateway.com/p_858-perl-send-sms-with-the-http-rest-api-code-sample.html)


## How to send sms from Pearl:##
Install a HTTP API user
1. [Download Ozeki SMS Gateway](https://ozeki-sms-gateway.com/p_727-download-sms-gateway.html)
2. [Connect Ozeki SMS Gateway to the mobile network](https://ozeki-sms-gateway.com/p_70-mobile-network.html)
3. [Create an HTTP SMS API user](https://ozeki-sms-gateway.com/p_2102-create-an-http-sms-api-user-account.html)
4. Download then extract the SendSms.pl.zip file
5. Open the sendsms.pl file in any text editor
6. Launch Ozeki SMS Gateway app
7. Run SendSms.pl Perl code in the command prompt
8. Check the logs to see if the SMS sent

## How to use the code

To use the code you need to import the Ozeki::Libs::Rest sms library. This sms library is also included in this repository with it's full source code. After the library is imported with the using statement, you need to define the username, password and the api url. You can create the username and password when you install an HTTP API user in your Ozeki SMS Gateway system.
The URL is the default http api URL to connect to your SMS gateway. If you run the SMS gateway on the same computer where your Pearl code is running, you can use 127.0.0.1 as the ip address. You need to change this if you install the sms gateway on a different computer (or mobile phone).

## Installation

To install the Ozeki::Libs::Rest module, you have to use these commands.

### Windows

    $ perl Build.PL

    $ ./Build

    $ ./Build install
    

### Linux

    $ perl Makefile.PL

    $ make

    $ sudo make install

## How to send a simple SMS message

 To use the ozeki_libs_rest you have to create a Configuration object.

```perl

    my $configuration = new Configuration();

    $configuration->{ username } = "username";

    $configuration->{ password } = "password";

    $configuration->{ apiurl } = "http://example.com/api";

```

To initialize a Message object we have to use the following code:


```perl

    my $msg = new Message();

    $msg->{ ToAddress } = "+36201111111";

    $msg->{ Text } = "Hello world!";

```

To send your message  we should create a MessageApi object.

The MessageApi constructor takes only one parameter which is a configuration object.

```perl

    my $api = new MessageApi($configuration);

    my $result = $api->Send(( $msg1 )); #We save the result into a variable
    
```


## Manual / API reference
To get a better understanding of the above **SMS code sample**, it is a good
idea to visit the webpage that explains this code in a more detailed way.
You can find videos, explanations and downloadable content on this URL.

Link: [How to send sms from Pearl](https://ozeki-sms-gateway.com/p_858-perl-send-sms-with-the-http-rest-api-code-sample.html)

If you wish to [send SMS through your Android mobile phone from C#](https://android-sms-gateway.com/), 
you need to [install Ozeki SMS Gateway on your Android](https://ozeki-sms-gateway.com/p_2847-how-to-install-ozeki-sms-gateway-on-android.html) 
mobile phone. It is recommended to use an Android mobile phone with a minimum of 
4GB RAM and a quad core CPU. Most devices today meet these specs. The advantage
of using your mobile, is that it is quick to setup and it often allows you
to [send sms free of charge](https://android-sms-gateway.com/p_246-how-to-send-sms-free-of-charge.html).

[Android SMS Gateway](https://android-sms-gateway.com)

## Get started now

Don't waste any time, download the repository now, and send your first SMS!


