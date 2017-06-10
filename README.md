# SimpleBlockchain [![Build Status](https://travis-ci.org/marianogabriels/simple_blockchain.svg?branch=master)](https://travis-ci.org/marianogabriels/simple_blockchain)
Based on:
 
 https://www.igvita.com/2014/05/05/minimum-viable-block-chain/
 
 https://bitcoin.org/bitcoin.pdf
 
## Instalation & Up: 

`bundle install`

`rackup`

##Getting started
 
`curl -X POST -H "Accept: application/json" -d '{ "data": "Block body" }' http://localhost:9292/block`

`curl -X GET -H "Accept: application/json" http://localhost:9292/blockchain/`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marianogabriels/simple_blockchain.

