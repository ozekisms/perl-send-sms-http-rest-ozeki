package Ozeki::Libs::Rest::MessageDeleteResult;

sub new {
    my $class = shift;
    my $self = {
        folder => shift,
        totalCount => 0,
        successCount => 0,
        failedCount => 0, 
        @messageIdsRemoveSucceeded => [],
        @messageIdsRemoveFailed => []
    };
    bless ($self, $class);
    return $self;
}

#Function to get a string representation of the object
sub stringify {
    my ($self) = @_;
    return "Total: ".$self->{ totalCount }.". Success: ".$self->{ successCount }.". Failed: ".$self->{ failedCount }.".";
}

1;