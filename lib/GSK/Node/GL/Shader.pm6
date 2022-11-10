use v6.c;

use NativeCall;
use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskGLShaderNodeAncestry is export of Mu
  where GskGLShaderNode | GskRenderNode;

class GSK::Node::GL::Shader:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;
  also does Positional;

  has GskGLShaderNode $!gsk-gsn is implementor;

  submethod BUILD ( :$gsk-gl-shader-node ) {
    self.setGskGLShaderNode($gsk-gl-shader-node) if $gsk-gl-shader-node
  }

  method setGskGLShaderNode (GskGLShaderNodeAncestry $_) {
    my $to-parent;

    $!gsk-gsn = do {
      when GskGLShaderNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskGLShaderNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskGLShaderNode
    is also<GskGLShaderNode>
  { $!gsk-gsn }

  multi method new (
    GskGLShaderNodeAncestry  $gsk-gl-shader-node,
                            :$ref                 = True
  ) {
    return unless $gsk-gl-shader-node;

    my $o = self.bless( :$gsk-gl-shader-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskGLShader()      $shader,
    graphene_rect_t()  $bounds,
                       $args        is copy,
                       @children,
                      :$encoding             = 'utf8',
                      :$size                 = $args ~~ CArray[uint8]
                                                 ?? $args.elems
                                                 !! -1
  ) {
    samewith(
       $shader,
       $bounds,
       $args,
       ArrayToCArray(GskRenderNode, @children),
      :$encoding,
      :$size
    )
  }
  multi method new (
    GskGLShader()          $shader,
    graphene_rect_t()      $bounds,
                           $args        is copy,
    CArray[GskRenderNode]  $children,
    Int()                  $n_children,
                          :$encoding             = 'utf8',
                          :$size                 = $args ~~ CArray[uint8]
                                                     ?? $args.elems
                                                     !! -1
  ) {
    my guint $n = $n_children;

    X::GLib::InvalidSize.new(
      message => 'Cannot have a size of < 1 if CArray!'
    ).throw if $args ~~ CArray && $size < 1;

    $args = do given $args {
      when .can('Str')   { $_ = .Str;  proceed        }
      when .can('Buf')   { $_ = .Buf;  proceed        }
      when .can('Blob')  { $_ = .Blob; proceed        }
      when Str | Blob    { GLib::Bytes.new($_)        }
      when CArray[uint8] { GLib::Bytes.new($_, $size) }

      default {
        X::GLib::UnknownType.new('Unrecognized type used in @args!').throw
      }
    }
    gsk_gl_shader_node_new($shader, $bounds, $args, $children, $n_children);
  }

  method get_args ( :$raw = False, :$bytes = False )
    is also<
      get-args
      args
    >
  {
    my $a = propReturnObject(
      gsk_gl_shader_node_get_args($!gsk-gsn);
      $raw,
      |GLib::Bytes.getTypePair
    );
    return $a if $bytes;
    ~$a
  }

  method get_child (
    Int()  $idx,
          :quick(:$fast)  = False,
          :$raw           = False,
          :slow(:$proper) = $fast.not
  )
    is also<
      get-child
      child
    >
  {
    my guint $i = $idx;

    returnProperNode(
      gsk_gl_shader_node_get_child($!gsk-gsn, $i),
      :$raw,
      :$proper
    );
  }
  method AT-POS (\k) {
    self.get_child(k);
  }
  method Array {
    my $a = [];
    $a.push: self[$_] for ^self.elems;
    $a;
  }

  method get_n_children
    is also<
      get-n-children
      n_children
      n-children
      elems
    >
  {
    gsk_gl_shader_node_get_n_children($!gsk-gsn);
  }

  method get_shader ( :$raw = False )
    is also<
      get-shader
      shader
    >
  {
    propReturnObject(
      gsk_gl_shader_node_get_shader($!gsk-gsn),
      $raw,
      |GSK::GLShader.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_gl_shader_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::GL::Shader;
  %render-node-types<GL::Shader> = {
    object    => O,
    node-type => GSK_GL_SHADER_NODE,
    type      => O.get_type
  }
}
