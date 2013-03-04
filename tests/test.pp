sip {'100':
    ensure  => present,
    type    => 'friend',
    host    => 'dynamic',
    secret  => 'MyPass123',
    context => 'full',
    mailbox => '100@default',
    permit  => '10.34.0.1/32',
    deny    => '10.34.0.2/32',
}