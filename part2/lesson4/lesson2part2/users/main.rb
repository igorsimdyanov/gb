# frozen_string_literal: true

require_relative 'user'
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

users = UserList.new(10).list
average_mark = users.sum(&:mark).to_f / users.size
users.select { |u| u.mark > average_mark }.sort_by(&:mark).each { |u| puts u }
