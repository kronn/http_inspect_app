#!/usr/bin/env ruby
# encoding: utf-8
# vim:ft=ruby

begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

root_dir = File.dirname(__FILE__)
$LOAD_PATH << root_dir unless $LOAD_PATH.include?(root_dir)

require 'sinatra/base'
require 'app'

run HttpInspectApp
