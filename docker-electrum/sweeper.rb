raise "SWEEP env var required" unless ENV["SWEEP"]

ENV["WALLET"] ||= "1GotBTCHdcFLGNGdiTqAKSXVyCuWKvbRqh"
ENV["FEE"] ||= "0.00007000"

puts "Attempting to sweep \"#{ENV["SWEEP"]}\" to wallet #{ENV["WALLET"]}..."
output = `electrum restore "#{ENV["SWEEP"]}"`
5.times do |i|
  begin
    output = `electrum payto -f #{ENV["FEE"]} #{ENV["WALLET"]} ! 2>&1 > tx.raw`
    hex = `cat tx.raw |jq .\"hex\"|sed s/\\"//g`.strip
    unless hex.empty?
      puts "Hex: #{hex}"
      pushresult = `curl 'https://blockchain.info/pushtx' -H 'authority: blockchain.info' -H 'cache-control: max-age=0' -H 'origin: https://www.blockchain.com' -H 'upgrade-insecure-requests: 1' -H 'content-type: application/x-www-form-urlencoded' -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'referer: https://www.blockchain.com/btc/pushtx' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9,nl;q=0.8,es;q=0.7' --data 'tx=#{hex}'`
      puts pushresult
    end
  rescue => exception
    puts exception
  end
end

puts output
