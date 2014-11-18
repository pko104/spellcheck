#!/usr/bin/env ruby
sentence = ARGV.join(' ')
require 'pry'

def correct(sentence)

  lotsofwords = File.read("lotsowords.txt").downcase.gsub(/[^a-zA-Z0-9\s']/, ' ').split(' ')

#puts lotsofwords
  alphabet = []
  spellchecked = []
  quality = {}
  changed = []

  ("a".."z").each do |n|
    alphabet << n
  end
  sentence_array = sentence.downcase.gsub(/[^a-zA-Z0-9\s']/, ' ').split(' ')
  word_count = {}
  lotsofwords.each do |wrd|
    if word_count.key?(wrd)
      word_count[wrd]+=1
    else
       word_count[wrd]=1
    end
  end



  sentence_array.each do |word|
    if word_count.include?(word)
      spellchecked << word
    else

        counter = 0
        quality = {}
        changed = []
        addswap = []


      until word_count.include?(word) do
        letter = 0


        #SWAP LETTER
        (word.length-1).times do
          swaplet = word.split("")
          swaplet[letter],swaplet[letter+1] = swaplet[letter+1],swaplet[letter]
          newword = swaplet.join("")
          changed << newword
          letter+=1
        end

        1.times do
          swaplet = word.split("")
          swaplet.push(swaplet.shift())
          newword = swaplet.join("")
          changed << newword
        end

        #ADD LETTER
        letter = 0
        (word.length-1).times do
          swaplet = word.split("")
          alphabet.each do |abc|
              swaplet = word.split("")
             swaplet.insert(letter, abc)
             newword = swaplet.join("")
             changed << newword
              end
          letter+=1

        1.times do
          alphabet.each do |abc|
          swaplet = word.split ("")
          swaplet.push(abc)
          newword = swaplet.join("")
          changed << newword
            end
          end
        end

        #ADD LETTER/SWAPPAGE
        letter = 0
        (word.length-1).times do
          swaplet = word.split("")
          alphabet.each do |abc|
             swaplet = word.split("")
             swaplet.insert(letter, abc)
             newword = swaplet.join("")
             addswap << newword
              end
            letter+=1
        1.times do
          alphabet.each do |abc|
          swaplet = word.split ("")
          swaplet.push(abc)
          newword = swaplet.join("")
          addswap << newword
            end
          end
        end

        addswap.each do |swapit|
          letter = 0
          swaplet = swapit.split("")
          swaplet[letter],swaplet[letter+1] = swaplet[letter+1],swaplet[letter]
          newword = swaplet.join("")
          changed << newword
          letter+=1
        1.times do
          swaplet = swapit.split("")
          swaplet.push(swaplet.shift())
          newword = swaplet.join("")
          changed << newword
        end
      end


        #DELETE LETTER
        letter = 0
       (word.length-1).times do
          swaplet = word.split("")
          swaplet.delete_at(letter)
          newword = swaplet.join("")
          changed << newword
          letter+=1
        end

        #QUALITY CHECK
        changed.each do |check|
          if word_count.include?(check)
              quality[check] = 1
              quality[check] = word_count[check]

          end
        end

        qualitychecked = quality.sort_by{|k,v| v}.reverse

        word = "#{qualitychecked[0][0]}"
        counter +=1
        spellchecked << word


      end

    end
    #binding.pry
  end
  puts spellchecked.join(' ').capitalize

end
correct(sentence)
