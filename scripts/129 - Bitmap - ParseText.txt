#===============================================================================
# ** Bitmap - Adds the ability to draw lines
#===============================================================================
class Bitmap
  def parse_text(lines_in=[], max_width=width)
    lines_out = []
    for line in lines_in
      words = line.scan(/(?:\S+|\s)/) # Also splits tabs and the like.
      word_range_start = 0
      word_range_end_min = -1
      word_range_end_max = words.size - 1
      while word_range_start <= word_range_end_max
        if word_range_end_min == word_range_end_max
          lines_out.push words[word_range_start..word_range_end_min].to_s
          word_range_start = word_range_end_min + 1
          # Skip whitespace words at the beginning/end of lines (not the \s*\r?\n\s*-parts).
          while not words[word_range_start].nil? and words[word_range_start] =~ /\s/
            word_range_start += 1
          end
          word_range_end_min = word_range_start - 1
          word_range_end_max = words.size - 1
        else
          word_range_end = (word_range_end_min + word_range_end_max + 1) / 2
          if text_size(words[word_range_start..word_range_end].to_s).width < max_width
            word_range_end_min = word_range_end
          else
            word_range_end_max = word_range_end - 1
          end
        end
      end
    end
    return lines_out
  end
end