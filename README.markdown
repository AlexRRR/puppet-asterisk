
puppet-asterisk
===============
[![Build Status](https://travis-ci.org/AlexRRR/puppet-asterisk.png)](https://travis-ci.org/AlexRRR/puppet-asterisk)

Creates a custom type and provider for managing Asterisk SIP configuration. The provider allows for simple SIP resource management, by managing /etc/asterisk/sip.conf and treating each SIP extension defined as an individual resource, so the following extension:

<pre><code>
[100]
type=friend
host=dynamic
secret=MyPass123
context=internal
mailbox=100@default
callgroup=1
pickupgroup=1
dtmfmode=rfc2833
canreinvite=no
permit=10.34.0.1/32
deny=0.0.0.0/0
</code></pre>

Can be expressed as:

<pre><code>
sip {'100':
    ensure  => present,
    type    => 'friend',
    host    => 'dynamic',
    secret  => 'MyPass123',
    context => 'internal'
    mailbox => '100@default'
    permit  => '10.34.0.1/32',
    deny    => '10.34.0.2/32',
}
</code></pre>


