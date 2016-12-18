# coding: utf-8
puts -> {
  # 这里是客户端连接: ` DRb.start_service `连接远程drb
  def connect(input = Pry.config.input, output = Pry.config.output)
    local_ip = UDPSocket.open {|s| s.connect(@host, 1); s.addr.last}
    DRb.start_service "druby://#{local_ip}:0"
    client = DRbObject.new(nil, uri)

    cleanup(client)

    input  = IOUndumpedProxy.new(input)
    output = IOUndumpedProxy.new(output)

    begin
      client.input  = input
      client.output = output
    rescue DRb::DRbConnError => ex
      if wait? || persist?
        sleep 1
        retry
      else
        raise ex
      end
    end

    if capture?
      client.stdout = $stdout
      client.stderr = $stderr
    end

    client.editor = ClientEditor

    client.thread = Thread.current

    sleep
    DRb.stop_service
  end

}[]
