use v6.c;

use GLib::Raw::Traits;

class GSK::TypeManifest does TypeManifest {

  method manifest {
    (
      GskBlendNode                   => 'GSK::Node::Blend',
      GskBlurNode                    => 'GSK::Node::Blur',
      GskBorderNode                  => 'GSK::Node::Border',
      GskCairoNode                   => 'GSK::Node::Cairo',
      GskCairoRenderer               => 'GSK::Renderer::Cairo',
      GskClipNode                    => 'GSK::Node::Clip',
      GskColorMatrixNode             => 'GSK::Node::ColorMatrix',
      GskColorNode                   => 'GSK::Node::Color',
      GskConicGradientNode           => 'GSK::Node::Gradient::Conic',
      GskContainerNode               => 'GSK::Node::Container',
      GskCrossFadeNode               => 'GSK::Node::CrossFade',
      GskDebugNode                   => 'GSK::Node::Debug',
      GskGLShader                    => 'GSK::GLShader',
      GskGLShaderNode                => 'GSK::Node::GL::Shader',
      GskInsetShadowNode             => 'GSK::Node::Shadow::Inset',
      GskLinearGradientNode          => 'GSK::Node::Gradient::Linear',
      GskOpacityNode                 => 'GSK::Node::Opacity',
      GskOutsetShadowNode            => 'GSK::Node::Shadow::Outset',
      GskRadialGradientNode          => 'GSK::Node::Gradient::Radial',
      GskRenderNode                  => 'GSK::RenderNode',
      GskRenderer                    => 'GSK::Renderer',
      GskRepeatNode                  => 'GSK::Node::Repeat',
      GskRepeatingLinearGradientNode => 'GSK::Node::Gradient::Repeating::Linear',
      GskRepeatingRadialGradientNode => 'GSK::Node::Gradient::Repeating::Radial',
      GskRoundedClipNode             => 'GSK::Node::RoundedClip',
      GskRoundedRect                 => 'GSK::RoundedRect',
      GskShadowNode                  => 'GSK::Node::Shadow',
      GskTextNode                    => 'GSK::Node::Text',
      GskTextureNode                 => 'GSK::Node::Texture',
      GskTransform                   => 'GSK::Transform',
      GskTransformNode               => 'GSK::Node::Transform'
    )
  }

}
