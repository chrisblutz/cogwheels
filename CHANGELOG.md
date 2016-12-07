## Uncommitted (`master` branch)
- Add `Configuration#stringify_keys`
- Refactor `Configuration#to_symbol_keys` to `Configuration#symbolize_keys`
- Fix immutability issues with `symbolize_keys` (previously `to_symbol_keys`)
- Fix immutable configurations so they freeze their internal hashes

## Previous Releases

### v0.2.0
- Add `Configuration#to_symbol_keys`
- Add default value capability
- Sub-hashes for `Configuration` objects are now `Configuration` objects themselves
