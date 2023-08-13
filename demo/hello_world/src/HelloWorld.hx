package;

import blueprint.Game;
import blueprint.Color;
import blueprint.Scene;
import blueprint.objects.Sprite;
import blueprint.graphics.Texture;

class HelloWorld extends Scene {
	var helloSprite:Sprite;

	public function new() {
		super();

		Game.clearColor = Color.BLACK;

		helloSprite = new Sprite(Game.width / 2, Game.height / 2);
		helloSprite.texture = Texture.getImageTex('assets/images/blueprint.png');
		add(helloSprite);
	}
}
