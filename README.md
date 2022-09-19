# myrouter

## big picture

To enable transparent proxy on router one need to prepare following things:

1. trusted dns server (optional)
2. rules to decide which connections need to be proxied and which are not.
3. a proxy client

## 1. trusted dns server (optional)

## 2. proxy rules

Use `iptables` to distribute connections based on their destination

## 3. proxy client

[trojan](https://github.com/trojan-gfw/trojan)
