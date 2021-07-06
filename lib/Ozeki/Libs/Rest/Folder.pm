package Ozeki::Libs::Rest::Folder;

#You can use these as enums to make it easier to manipulate your messages
use constant {
    Inbox   => 'inbox',
    Outbox   => 'outbox',
    Sent   => 'sent',
    NotSent   => 'notsent',
    Deleted   => 'deleted',
};

1;