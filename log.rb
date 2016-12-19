
  def log
    open("/Users/emacs/aaa.log",'a') do |f|
      yield(f)
    end
  end

  log{|f| f.puts "aaaaa" }
