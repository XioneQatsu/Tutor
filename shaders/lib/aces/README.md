# glsl-tone-map [![frozen](http://badges.github.io/stability-badges/dist/frozen.svg)](http://github.com/badges/stability-badges)

A collection of tone mapping GLSL functions, available as modules for glslify. Mostly taken from [here](https://bruop.github.io/tonemapping/) and [here](https://www.shadertoy.com/view/WdjSW3).

## Installation

```bash
npm install glsl-tone-map
```

[![NPM](https://nodei.co/npm/glsl-tone-map.png)](https://nodei.co/npm/glsl-tone-map/)

## Usage

```glsl
#pragma glslify: aces = require(glsl-tone-map/aces)

void main() {
	// ...
	color.rgb = aces(color.rgb);
}
```

## License

MIT. See [license file](https://github.com/dmnsgn/glsl-tone-map/blob/master/LICENSE.md).
