package Ozeki::Libs::Rest::MessageSendResult;

sub new {
    my $class = shift;
    my $self = {
        message => shift,
        status => shift,
        statusMessage => shift
    };
    bless ($self, $class);
    return $self;
}

#Function to get a string representation of the object
sub stringify {
    my ($self) = @_;
    return $self->{ status }.", ".$self->{ message }->stringify;
}

1;