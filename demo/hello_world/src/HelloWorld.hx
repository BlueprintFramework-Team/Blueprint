package;

import blueprint.Game;
import blueprint.Scene;
import blueprint.objects.Sprite;
import blueprint.graphics.Texture;

class HelloWorld extends Scene {
	var helloSprite:Sprite;

	public function new() {
		super();

		helloSprite = new Sprite(Game.window.width / 2, Game.window.height / 2);
		helloSprite.texture = Texture.getImageTex('assets/images/blueprint.png');
		add(helloSprite);
	}
}
