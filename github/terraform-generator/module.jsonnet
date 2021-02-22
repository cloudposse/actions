local name = std.extVar('name');
local source = std.extVar('source');
local attributes = std.parseJson(std.extVar('attributes'));

{
  "module": {
    [ name ]: {
      "source": source
    } + attributes
  }
}
