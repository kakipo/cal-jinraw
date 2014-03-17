# coding: utf-8
class PriceRange < ActiveHash::Base
  self.data = [
    {id: 1, name: '無料', alias_name: 'hoge'},
    {id: 2, name: '〜1000円', alias_name: 'hoge'},
    {id: 3, name: '〜2000円', alias_name: 'hoge'},
    {id: 4, name: '〜3000円', alias_name: 'hoge'},
    {id: 5, name: '3001円〜', alias_name: 'hoge'}
  ]
end