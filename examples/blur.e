use v6.c;

use GSK::Raw::Types:ver<4>;

use GLib::Timeout;
use Graphene::Rect;
use GDK::Pixbuf;
use GDK::Texture:ver<4>;
use GSK::Node::Blur:ver<4>;
use GSK::Node::Texture:ver<4>;
use GTK::Application:ver<4>;
use GTK::Adjustment:ver<4>;
use GTK::Box;
use GTK::Image:ver<4>;
use GTK::Scale:ver<4>;
use GTK::Snapshot:ver<4>;

my ($blur-inc, $radius) = (0, 0);

my $rect;

sub update-image ($i, $t, $radius = 0) {
  my $r = GSK::Node::Blur.new(
    GSK::Node::Texture.new( GDK::Texture.new-for-pixbuf($t), $rect ),
    $radius
  );

  my $s = GTK::Snapshot.new;
  $s.append-node($r);
  $i.paintable = $s.to-paintable($rect);
}

sub MAIN (
   $filename = "{ $*HOME }/Pictures/Digital Blasphemy/idylic.png",
) {
  die "Image '{ $filename }' not found!" unless $filename.IO.r;

  my $app = GTK::Application.new(
    title  => 'GTK Blur w/ Slider',
    width  => 1024,
    height => 768
  );

  $app.Activate.tap: SUB {
    my $texture  = GDK::Pixbuf.new-from-file($filename);
    my $blur-max = min( .width, .height ) / 4 given $texture;
    my $adj      = GTK::Adjustment.new( upper => $blur-max );
    my $box      = GTK::Box.new-vbox;
    my $s        = GTK::Scale.new-hscale($adj);

    $rect = Graphene::Rect.new(0, 0, .width, .height) given $texture;

    my $i = GTK::Image.new;

    $s.Value-Changed.tap: SUB {
      update-image($i, $texture, $s.value);
    }

    $box.pack-start($i, True, True);
    $box.pack-start($s);

    update-image($i, $texture);
    $app.window.child = $box;
    $app.window.present;
  }

  $app.run;
}
