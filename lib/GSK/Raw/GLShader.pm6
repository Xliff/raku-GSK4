use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GSK::Raw::Definitions:ver<4>;

unit package GSK::Raw::GLShader;

### /usr/src/gtk4-4.8.1+ds/gsk/gskglshader.h

sub gsk_gl_shader_compile (
  GskGLShader             $shader,
  GskRenderer             $renderer,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_find_uniform_by_name (
  GskGLShader $shader,
  Str         $name
)
  returns gint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_format_args (GskGLShader $shader)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

# sub gsk_gl_shader_format_args_va (
#   GskGLShader $shader,
#   va_list     $uniforms
# )
#   returns GBytes
#   is      native(gsk)
#   is      export
# { * }

sub gsk_gl_shader_get_arg_bool (
  GskGLShader $shader,
  GBytes      $args,
  gint        $idx
)
  returns uint32
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_float (
  GskGLShader $shader,
  GBytes      $args,
  gint        $idx
)
  returns gfloat
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_int (
  GskGLShader $shader,
  GBytes      $args,
  gint        $idx
)
  returns gint32
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_uint (
  GskGLShader $shader,
  GBytes      $args,
  gint        $idx
)
  returns guint32
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_vec2 (
  GskGLShader     $shader,
  GBytes          $args,
  gint            $idx,
  graphene_vec2_t $out_value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_vec3 (
  GskGLShader     $shader,
  GBytes          $args,
  gint            $idx,
  graphene_vec3_t $out_value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_arg_vec4 (
  GskGLShader     $shader,
  GBytes          $args,
  gint            $idx,
  graphene_vec4_t $out_value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_args_size (GskGLShader $shader)
  returns gsize
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_n_textures (GskGLShader $shader)
  returns gint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_n_uniforms (GskGLShader $shader)
  returns gint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_resource (GskGLShader $shader)
  returns Str
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_source (GskGLShader $shader)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_uniform_name (
  GskGLShader $shader,
  gint        $idx
)
  returns Str
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_uniform_offset (
  GskGLShader $shader,
  gint        $idx
)
  returns gint
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_get_uniform_type (
  GskGLShader $shader,
  gint        $idx
)
  returns GskGLUniformType
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_free_to_args (GskShaderArgsBuilder $builder)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_get_type
  returns GType
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_new (
  GskGLShader $shader,
  GBytes      $initial_values
)
  returns GskShaderArgsBuilder
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_ref (GskShaderArgsBuilder $builder)
  returns GskShaderArgsBuilder
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_bool (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  gboolean             $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_float (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  gfloat               $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_int (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  gint32               $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_uint (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  guint32              $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_vec2 (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  graphene_vec2_t      $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_vec3 (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  graphene_vec3_t      $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_set_vec4 (
  GskShaderArgsBuilder $builder,
  gint                 $idx,
  graphene_vec4_t      $value
)
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_to_args (GskShaderArgsBuilder $builder)
  returns GBytes
  is      native(gsk)
  is      export
{ * }

sub gsk_shader_args_builder_unref (GskShaderArgsBuilder $builder)
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_new_from_bytes (GBytes $sourcecode)
  returns GskGLShader
  is      native(gsk)
  is      export
{ * }

sub gsk_gl_shader_new_from_resource (Str $resource_path)
  returns GskGLShader
  is      native(gsk)
  is      export
{ * }
