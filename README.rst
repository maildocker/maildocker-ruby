Maildocker-Ruby
===============

This library allows you to quickly and easily send emails through
Maildocker using Ruby.

Example
-------

.. code:: ruby

    require 'maildocker'

    md = Maildocker::Client.new(api_user: '0cc175b9c0f1b6a831c', api_key: '92eb5ffee6ae2fec3ad')

    # OR

    md = Maildocker::Client.new do |c|
      c.api_user = '0cc175b9c0f1b6a831c'
      c.api_key = '92eb5ffee6ae2fec3ad'
    end

    # THEN

    mail = Maildocker::Mail.new do |m|
      m.add_to('john.snow@thrones.com', 'John Snow')
      m.set_from('maildocker@ecentry.io', 'Maildocker')
      m.subject = 'maildocker-ruby-library'
      m.text = '**{{system}}** ({{url}})'
      m.add_attachment('spreadsheet.xls')
    end

    md.send(mail)

    # OR

    md.send(Maildocker::Mail.new(to: 'john.snow@thrones.com', from: 'maildocker@ecentry.io', subject: 'maildocker-ruby-library', text: '**{{system}}** ({{url}})'))
