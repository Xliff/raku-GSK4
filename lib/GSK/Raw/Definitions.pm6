use v6.c;

use NativeCall;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GSK::Raw::Definitions:ver<4>;

constant gsk is export = 'gtk-4';

class GskGLShader   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskTransform  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRenderer   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRenderNode is repr<CPointer> does GLib::Roles::Pointers is export { }
