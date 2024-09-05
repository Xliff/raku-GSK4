use v6.c;

use Method::Also;

use NativeCall;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::GLShader:ver<4>;

use GLib::Roles::Implementor;

class GSK::GLShader:ver<4> {
  also does GLib::Roles::Implementor;

  has GskGLShader $!gsk-gl-shader is implementor;

  submethod BUILD ( :$!gsk-gl-shader ) { }

  method GSK::Raw::Definitions::GskGLShader
  { $!gsk-gl-shader }

  multi method new (Str $source, :$encoding = 'utf8') {
    samewith( $source.encode($encoding) );
  }
  multi method new (Blob $source) {
    samewith( CArray[uint8].new($source), $source.bytes );
  }
  multi method new (CArray[uint8] $source, Int() $size ) {
    ::?CLASS.new_from_bytes( GLib::Bytes.new($source, $size) );
  }

  method new_from_bytes (GBytes() $sourcecode) is also<new-from-bytes> {
    gsk_gl_shader_new_from_bytes($!gsk-gl-shader, $sourcecode);
  }

  method new_from_resource (Str() $resource_path)
    is also<new-from-resource>
  {
    my $gsk-gl-shader = gsk_gl_shader_new_from_resource($resource_path);

    $gsk-gl-shader ?? self.bless( :$gsk-gl-shader ) !! Nil;
  }

  method compile (
    GskRenderer()           $renderer,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $rv = gsk_gl_shader_compile($!gsk-gl-shader, $renderer, $error);
    set_error($error);
    $rv;
  }

  method find_uniform_by_name (Str() $name) is also<find-uniform-by-name> {
    gsk_gl_shader_find_uniform_by_name($!gsk-gl-shader, $name);
  }

  method format_args is also<format-args> {
    gsk_gl_shader_format_args($!gsk-gl-shader);
  }

  method get_arg_bool (GBytes() $args, Int() $idx) is also<get-arg-bool> {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_bool($!gsk-gl-shader, $args, $i);
  }

  method get_arg_float (GBytes() $args, Int() $idx) is also<get-arg-float> {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_float($!gsk-gl-shader, $args, $i);
  }

  method get_arg_int (GBytes() $args, Int() $idx) is also<get-arg-int> {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_int($!gsk-gl-shader, $args, $i);
  }

  method get_arg_uint (GBytes() $args, Int() $idx) is also<get-arg-uint> {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_uint($!gsk-gl-shader, $args, $i);
  }


  proto method get_arg_vec2 (|)
    is also<get-arg-vec2>
  { * }

  multi method get_arg_vec2 (
    GBytes()  $args,
    Int()     $idx,
             :$raw = False
  ) {
    samewith($args, $idx, Graphene::Vec2.alloc, :$raw)
  }
  multi method get_arg_vec2 (
    GBytes()           $args,
    Int()              $idx,
    graphene_vec2_t()  $out_value,
                      :$raw = False
  )

  {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec2($!gsk-gl-shader, $args, $i, $out_value);
    propReturnObject( $out_value, $raw, |Graphene::Vec2.getTypePair );
  }

  method get_arg_vec3 (
    GBytes()          $args,
    Int()             $idx,
    graphene_vec3_t() $out_value
  )
    is also<get-arg-vec3>
  {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec3($!gsk-gl-shader, $args, $i, $out_value);
  }

  method get_arg_vec4 (
    GBytes()          $args,
    Int()             $idx,
    graphene_vec4_t() $out_value
  )
    is also<get-arg-vec4>
  {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec4($!gsk-gl-shader, $args, $i, $out_value);
  }

  method get_args_size is also<get-args-size> {
    gsk_gl_shader_get_args_size($!gsk-gl-shader);
  }

  method get_n_textures is also<get-n-textures> {
    gsk_gl_shader_get_n_textures($!gsk-gl-shader);
  }

  method get_n_uniforms is also<get-n-uniforms> {
    gsk_gl_shader_get_n_uniforms($!gsk-gl-shader);
  }

  method get_resource is also<get-resource> {
    gsk_gl_shader_get_resource($!gsk-gl-shader);
  }

  method get_source is also<get-source> {
    gsk_gl_shader_get_source($!gsk-gl-shader);
  }

  method get_uniform_name (Int() $idx) is also<get-uniform-name> {
    my gint $i = $idx;

    gsk_gl_shader_get_uniform_name($!gsk-gl-shader, $i);
  }

  method get_uniform_offset (Int() $idx) is also<get-uniform-offset> {
    my gint $i = $idx;

    gsk_gl_shader_get_uniform_offset($!gsk-gl-shader, $i);
  }

  method get_uniform_type (Int() $idx) is also<get-uniform-type> {
    my gint $i = $idx;

    gsk_gl_shader_get_uniform_type($!gsk-gl-shader, $i);
  }

}

class GSK::GLShader::ArgsBuilder {
  also does GLib::Roles::Implementor;

  has GskShaderArgsBuilder $!gsk-glsab is implementor;

  submethod BUILD ( :$gsk-gl-shader-ab ) {
    $!gsk-glsab = $gsk-gl-shader-ab if $gsk-gl-shader-ab
  }

  method GSK::Raw::Definitions::GskShaderArgsBuilder
  { $!gsk-glsab }

  multi method new (GskGLShader() $shader, GBytes() $initial_values) {
    my $gsk-gl-shader-ab = gsk_shader_args_builder_new(
      $shader,
      $initial_values
    );

    $gsk-gl-shader-ab ?? self.bless( :$gsk-gl-shader-ab ) !! Nil;
  }

  method free_to_args is also<free-to-args> {
    gsk_shader_args_builder_free_to_args($!gsk-glsab);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_shader_args_builder_get_type,
      $n,
      $t
    );
  }

  method ref {
    gsk_shader_args_builder_ref($!gsk-glsab);
    self;
  }

  method set_bool (Int() $idx, Int() $value) is also<set-bool> {
    my gint     $i = $idx;
    my gboolean $v = $value.so.Int;

    gsk_shader_args_builder_set_bool($!gsk-glsab, $i, $v);
  }

  method set_float (Int() $idx, Num() $value) is also<set-float> {
    my gint   $i = $idx;
    my gfloat $v = $value;

    gsk_shader_args_builder_set_float($!gsk-glsab, $i, $v);
  }

  method set_int (Int() $idx, Int() $value) is also<set-int> {
    my gint32 $i = $idx;
    my gint32 $v = $value;

    gsk_shader_args_builder_set_int($!gsk-glsab, $i, $v);
  }

  method set_uint (Int() $idx, Int() $value) is also<set-uint> {
    my gint    $i = $idx;
    my guint32 $v = $value;

    gsk_shader_args_builder_set_uint($!gsk-glsab, $i, $v);
  }

  method set_vec2 (Int() $idx, graphene_vec2_t() $value) is also<set-vec2> {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec2($!gsk-glsab, $i, $value);
  }

  method set_vec3 (Int() $idx, graphene_vec3_t() $value) is also<set-vec3> {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec3($!gsk-glsab, $i, $value);
  }

  method set_vec4 (Int() $idx, graphene_vec4_t() $value) is also<set-vec4> {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec4($!gsk-glsab, $i, $value);
  }

  method to_args is also<to-args> {
    gsk_shader_args_builder_to_args($!gsk-glsab);
  }

  method unref {
    gsk_shader_args_builder_unref($!gsk-glsab);
  }

}
