use v6.c;

use GSK::Raw::Types:ver<4>;

use Graphene::Rect;
use Graphene::Point;
use GDK::RGBA:ver<4>;
use GTK::Application:ver<4>;
use GTK::Image:ver<4>;
use GTK::Snapshot:ver<4>;
use GSK::Node::Gradient::Linear:ver<4>;
use GLib::Timeout;

my %size = (
  width  => 1200,
  height => 1024
);

my $rot = 0;
my $r   = Graphene::Rect.new( 0, 0, |%size<width height> );
my $s   = Graphene::Point.new( 0, 0 );
my $e   = Graphene::Point.new( |%size<width height> );
my @s   = [
  GskColorStop.new( offset => 0e0,  color => GDK::RGBA.new(1, 1, 1) ),
  GskColorStop.new( offset => 0.25, color => GDK::RGBA.new(1, 0, 0) ),
  GskColorStop.new( offset => 0.5,  color => GDK::RGBA.new(0, 1, 0) ),
  GskColorStop.new( offset => 0.75, color => GDK::RGBA.new(0, 0, 1) ),
  GskColorStop.new( offset => 0.99, color => GDK::RGBA.new(1, 1, 1) )
];

sub MAIN {
  my $app = GTK::Application.new(
    id     => 'org.genex.gsk.gradient.conic',
    width  => %size<width>,
    height => %size<height>
  );

  $app.Activate.tap: SUB {
    my $i = GTK::Image.new;

    sub update-image {
      my $sn = GTK::Snapshot.new;
      my $g  = GSK::Node::Gradient::Linear.new($r, $s, $e, @s);
      $sn.append-node($g);
      $i.paintable = $sn.to-paintable($r);
    }

    GLib::Timeout.add(10, SUB {
      CATCH { default { .message.say; .backtrace.concise.say } }

      @s.map({ .offset += 0.01; $_ });
      if @s.tail.offset > 1 {
        @s .= rotate(-1);
        @s.head.offset = 0e0
      }

      update-image;
      G_SOURCE_CONTINUE;
    });

    update-image;
    $app.window.child = $i;
    $app.window.present;
  }

  $app.run;
}
