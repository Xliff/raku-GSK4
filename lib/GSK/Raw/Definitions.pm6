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

class GskBlendNode                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskBlurNode                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskBorderNode                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskCairoNode                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskClipNode                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskColorMatrixNode             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskColorNode                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskConicGradientNode           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskContainerNode               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskCrossFadeNode               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskDebugNode                   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskGLShaderNode                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskInsetShadowNode             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskLinearGradientNode          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskOpacityNode                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskOutsetShadowNode            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRadialGradientNode          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRepeatNode                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRepeatingLinearGradientNode is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRepeatingRadialGradientNode is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskRoundedClipNode             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskShadowNode                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskTextNode                    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskTextureNode                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GskTransformNode               is repr<CPointer> does GLib::Roles::Pointers is export { }
