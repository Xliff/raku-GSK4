use v6.c;

use GSK::Raw::Types:ver<4>;

use Graphene::Rect;
#use GDK::Augment::Pixbuf:ver<4>;
#use GDK::Pixbuf;
use GSK::Node::Color:ver<4>;
use GSK::Node::Opacity:ver<4>;
use GDK::RGBA:ver<4>;
use GDK::Texture:ver<4>;
use GTK::Snapshot:ver<4>;
use GTK::Application:ver<4>;
use GTK::Image:ver<4>;

my ($rect, $texture);

sub update-image ($i, $t) {
  my $c = GDK::RGBA.new( r => 255, a => 128 );

  my $cn = GSK::Node::Color.new($c, $rect);
  my $n  = GSK::Node::Opacity.new($cn, 0.5);

  my $s = GTK::Snapshot.new;
  $s.append-texture($t, $rect);
  $s.append-node($cn);
  $i.paintable = $s.to-paintable($rect);
}

sub MAIN (
   $filename = "{ $*HOME }/Pictures/Digital Blasphemy/idylic.png",
  :$frames   = 120
) {
  die "Image '{ $filename }' not found!" unless $filename.IO.r;

  my $app = GTK::Application.new(
    title  => 'GSK Color and Opacity',
    width  => 1024,
    height => 768
  );

  my $pb;

  $app.Activate.tap: SUB {
    $pb      = GDK::Pixbuf.new-from-file($filename);
    $rect    = Graphene::Rect.new(0, 0, .width, .height) given $pb;
    $texture = GDK::Texture.new-for-pixbuf($pb);

    my $i = GTK::Image.new;
    update-image($i, $texture);

    $app.window.child = $i;
    $app.window.present;
  }

  $app.run;

  # $anim.set-loop($true);
  # say 'Done';
}
