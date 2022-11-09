use v6.c;

use NativeCall;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::GLShader:ver<4>;

use GLib::Roles::Implementor;

class GSK::GLShader:ver<4> {
  also does GLib::Roles::Implementor;

  has GskGLShader $!gsk-gl-shader is implementor;

  method new (Str $source, :$encoding = 'utf8') {
    samewith( $source.encode($encoding) );
  }
  method new (Blob $source) {
    samewith( CArray[uint8].new($source), $source.bytes );
  }
  method new (CArray[uint8] $source, Int() $size ) {
    ::?CLASS.new_from_bytes( GLib::Bytes.new($source, $size) );
  }
  method new_from_bytes (GBytes() $sourcecode) {
    gsk_gl_shader_new_from_bytes($!gsk-gl-shader, $sourcecode);
  }

  method new_from_resource (Str() $resource_path) {
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

  method find_uniform_by_name (Str() $name) {
    gsk_gl_shader_find_uniform_by_name($!gsk-gl-shader, $name);
  }

  method format_args {
    gsk_gl_shader_format_args($!gsk-gl-shader);
  }

  method get_arg_bool (GBytes() $args, Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_bool($!gsk-gl-shader, $args, $i);
  }

  method get_arg_float (GBytes() $args, Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_float($!gsk-gl-shader, $args, $i);
  }

  method get_arg_int (GBytes() $args, Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_int($!gsk-gl-shader, $args, $i);
  }

  method get_arg_uint (GBytes() $args, Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_uint($!gsk-gl-shader, $args, $i);
  }

  method get_arg_vec2 (
    GBytes()          $args,
    Int()             $idx,
    graphene_vec2_t() $out_value
  ) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec2($!gsk-gl-shader, $args, $i, $out_value);
  }

  method get_arg_vec3 (
    GBytes()          $args,
    Int()             $idx,
    graphene_vec3_t() $out_value
  ) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec3($!gsk-gl-shader, $args, $i, $out_value);
  }

  method get_arg_vec4 (
    GBytes()          $args,
    Int()             $idx,
    graphene_vec4_t() $out_value
  ) {
    my gint $i = $idx;

    gsk_gl_shader_get_arg_vec4($!gsk-gl-shader, $args, $i, $out_value);
  }

  method get_args_size {
    gsk_gl_shader_get_args_size($!gsk-gl-shader);
  }

  method get_n_textures {
    gsk_gl_shader_get_n_textures($!gsk-gl-shader);
  }

  method get_n_uniforms {
    gsk_gl_shader_get_n_uniforms($!gsk-gl-shader);
  }

  method get_resource {
    gsk_gl_shader_get_resource($!gsk-gl-shader);
  }

  method get_source {
    gsk_gl_shader_get_source($!gsk-gl-shader);
  }

  method get_uniform_name (Int() $idx) {

    gsk_gl_shader_get_uniform_name($!gsk-gl-shader, $i);
  }

  method get_uniform_offset (Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_uniform_offset($!gsk-gl-shader, $i);
  }

  method get_uniform_type (Int() $idx) {
    my gint $i = $idx;

    gsk_gl_shader_get_uniform_type($!gsk-gl-shader, $i);
  }

}

class GSK::GLShader::ArgsBuilder {
  also does GLib::Roles::Implementor;

  has GskGLShaderArgsBuilder $!gsk-glsab is implementor;

  submethod BUILD ( :$gsk-gl-shader-ab ) {
    $!gsk-glsab = $gsk-gl-shader-ab if $gsk-gl-shader-ab
  }

  method GSK::Raw::Definitions::GskGLShaderArgsBuilder
  { $!gsk-glsab }

  multi method new (GskGLShader() $shader, GBytes() $initial_values) {
    my $gsk-gl-shader-ab = gsk_shader_args_builder_new(
      $shader,
      $initial_values
    );

    $gsk-gl-shader-ab ?? self.bless( :$gsk-gl-shader-ab ) !! Nil;
  }

  method free_to_args {
    gsk_shader_args_builder_free_to_args($!gsk-glsab);
  }

  method get_type {
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

  method set_bool (Int() $idx, Int() $value) {
    my gint     $i = $idx;
    my gboolean $v = $value.so.Int;

    gsk_shader_args_builder_set_bool($!gsk-glsab, $i, $v);
  }

  method set_float (Int() $idx, Num() $value) {
    my gint   $i = $idx;
    my gfloat $v = $value;

    gsk_shader_args_builder_set_float($!gsk-glsab, $i, $v);
  }

  method set_int (Int() $idx, Int() $value) {
    my gint32 $i = $idx;

    gsk_shader_args_builder_set_int($!gsk-glsab, $i, $v);
  }

  method set_uint (Int() $idx, Int() $value) {
    my gint    $i = $idx;
    my guint32 $v = $value;

    gsk_shader_args_builder_set_uint($!gsk-glsab, $i, $v);
  }

  method set_vec2 (Int() $idx, graphene_vec2_t() $value) {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec2($!gsk-glsab, $i, $v);
  }

  method set_vec3 (Int() $idx, graphene_vec3_t() $value) {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec3($!gsk-glsab, $i, $value);
  }

  method set_vec4 (Int() $idx, graphene_vec4_t() $value) {
    my gint $i = $idx;

    gsk_shader_args_builder_set_vec4($!gsk-glsab, $i, $value);
  }

  method to_args {
    gsk_shader_args_builder_to_args($!gsk-glsab);
  }

  method unref {
    gsk_shader_args_builder_unref($!gsk-glsab);
  }

}
