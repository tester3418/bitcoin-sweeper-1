# Bitcoin Sweeper

Bitcoin Sweeper is a dockerized electrum with a script to sweep an electrum mnemonic or private key to a destination wallet.

## Installation

`docker pull dennisvink/bitcoin-sweeper`

## Examples

Example usage:

`docker run -e'SWEEP=crucial dad cup domain escape labor spice toy cry budget piece minor' bitcoin-sweeper`

By default it sweeps the contents of the wallet to 1GotBTCHdcFLGNGdiTqAKSXVyCuWKvbRqh. To set your wallet use:

`docker run -e'SWEEP=your_key_or_mnemonic' -e'WALLET=1GotBTCHdcFLGNGdiTqAKSXVyCuWKvbRqh' bitcoin-sweeper`

The default fee is 0.00007000 BTC. You can override it with the FEE environment variable.

Example:

`docker run -e'SWEEP=your_key_or_mnemonic' -e'WALLET=1GotBTCHdcFLGNGdiTqAKSXVyCuWKvbRqh' -e'FEE=0.00003000' bitcoin-sweeper`

The signed transaction hex will be outputted to STDOUT and posted to https://blockchain.info/pushtx.

## Building from source

```
git clone git@github.com:dennisvink/bitcoin-sweeper.git
cd bitcoin-sweeper
docker build -t bitcoin-sweeper docker-electrum
```

