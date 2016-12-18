puts -> {
  # ` while read do ` => wait ` input and output and thread `
  Client = Struct.new(:input, :output, :thread, :stdout, :stderr, :editor) do
    # Waits until both an input and output are set
    def wait
      sleep 0.01 until input and output and thread
    end

    # Tells the client the session is terminated
    def kill
      thread.run
    end

    # @return [InputProxy] Proxy for the input
    def input_proxy
      InputProxy.new input
    end
  end

  # @client = PryRemote::Client.new
  # DRb.start_service uri, @client

  # @client.wait
  # @client.kill
        
  # Pry.start(@object, @options.merge(:input => client.input_proxy, :output => client.output, :hooks => @hooks))        
  
}[]
