# Ozeki-Libs-Rest

The Ozeki-Libs-Rest library is a tool for Ozeki SMS Gateway. With this library you can send, delete, mark and receive SMS messages using the built in api of the SMS Gateway.

To use the example code called SendSms.perl you have to set up an http_user in your SMS Gateway.

It is also important to mention, that you have to run the code on a computer where the SMS Gateway gateway is running.

## Installation

To install the ozeki_libs_rest gem, you have to execute the following command:

# Windows

    $ perl Build.PL

    $ ./Build

    $ ./Build install
    

# Linux

    $ perl Makefile.PL

    $ make

    $ make install

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
