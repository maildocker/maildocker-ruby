require 'mime/types'

module Maildocker
  class Mail
    attr_accessor :to, :from, :subject, :template, :text, :html, :cc, :bcc,
      :reply_to, :date, :attachments, :images

    def initialize(params = {})
      params.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      @headers     ||= {}
      @merge_vars  ||= {}
      @attachments ||= []
      @images      ||= []
      @to          ||= []
      yield self if block_given?
    end

    def set_from(address, name = nil)
      from = {email: address}
      from[:name] = name unless name.nil?
      @from = from
      self
    end

    def add_to(address, name = nil)
      to = {email: address}
      to[:name] = name unless name.nil?
      @to << to
      self
    end

    def add_attachment(path, name = nil)
      file   = File.new(path)
      name ||= File.basename(file)
      type ||= MIME::Types.type_for(path).first.content_type
      @attachments << {content: file, name: name, type: type}
    end

    def add_image(path, name = nil)
      file   = File.new(path)
      name ||= File.basename(file)
      type ||= MIME::Types.type_for(path).first.content_type
      @images << {content: file, name: name, type: type}
    end

    def to_h
      payload = {
        :from        => @from,
        :subject     => @subject,
        :template    => @template,
        :merge_vars  => @merge_vars,
        :to          => @to,
        :date        => @date,
        :replyto     => @reply_to,
        :cc          => @cc,
        :bcc         => @bcc,
        :text        => @text,
        :html        => @html,
        :attachments => ({} unless @attachments.empty?),
        :images      => ({} unless @images.empty?)
      }.reject {|k,v| v.nil?}
      payload
    end
  end
end
