package {

	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;

	public class main extends Sprite {

		public static var worldArray:Array = [
		[1, 1, 0],
		[1, 0, 0],
		[0, 0, 0]
		];
		public var tileSprite:Sprite = new Sprite  ;
		public static var xOffset:int = -30;
		public static var yOffset:int = -30;
		public static var xSelect:int = 0;
		public static var ySelect:int = 0;
		public static const blockSize:int = 10;

		public function main () {
			stage.addEventListener (KeyboardEvent.KEY_DOWN, keydown_e);
			render ();
		}

		public function keydown_e (e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.A) {
				xSelect--;
				if (xSelect < 0) {
					xSelect = 0;
				}
			} else if (e.keyCode == Keyboard.S) {
				ySelect++;
				if (ySelect > worldArray[0].length - 1) {
					ySelect = worldArray[0].length - 1;
				}
			} else if (e.keyCode == Keyboard.D) {
				xSelect++;
				if (xSelect > worldArray.length - 1) {
					xSelect = worldArray.length - 1;
				}
			} else if (e.keyCode == Keyboard.W) {
				ySelect--;
				if (ySelect < 0) {
					ySelect = 0;
				}
			}

			if (e.keyCode == Keyboard.SPACE && worldArray[xSelect][ySelect] == 1) {
				var didClone:Boolean = false;

				if (worldArray[xSelect + 1][ySelect] == 0) {
					if (worldArray[xSelect][ySelect + 1] == 0) {
						cloneAndMove (xSelect, ySelect);
						didClone = true;
					}
				}
				if (didClone == true) {
					if (xSelect >= worldArray.length - 2) {
						extendYAxis ();
					}
					if (ySelect >= worldArray[0].length - 2) {
						extendXAxis ();
					}
				}
			}

			render ();
		}

		public function render ():void {
			//begin world render
			while (tileSprite.numChildren > 0) {
				tileSprite.removeChildAt (0);
			}
			tileSprite = null;
			tileSprite = new Sprite();
			stage.addChild (tileSprite);
			for (var xPos:int = 0; xPos < worldArray.length; xPos++) {
				for (var yPos:int = 0; yPos < worldArray[0].length; yPos++) {
					drawTile (worldArray[xPos][yPos],xPos, yPos, xOffset, yOffset);
				}
			}
			//end world render
			drawTile (2, xSelect, ySelect, xOffset, yOffset);//selector
		}

		public function drawTile (id:int, x1:int, y1:int, ox:int, oy:int):void {
			if (id == 0) {
				var unclone:unclone1 = new unclone1();
				unclone.x = x1 * blockSize - ox;
				unclone.y = y1 * blockSize - oy;
				tileSprite.addChild (unclone);
			} else if (id == 1) {
				var clone:clone1 = new clone1();
				clone.x = x1 * blockSize - ox;
				clone.y = y1 * blockSize - oy;
				tileSprite.addChild (clone);
			} else if (id == 2) {
				var selection_:selection1 = new selection1();
				selection_.x = x1 * blockSize - ox;
				selection_.y = y1 * blockSize - oy;
				tileSprite.addChild (selection_);

				if (selection_.x < 2 * blockSize) {
					xOffset -=  blockSize;
				} else if (selection_.x > stage.stageWidth - 3 * blockSize) {
					xOffset +=  blockSize;
				}

				if (selection_.y < 3 * blockSize) {
					yOffset -=  blockSize;
				} else if (selection_.y > stage.stageHeight - 3 * blockSize) {
					yOffset +=  blockSize;
				}

			}
		}

		public function cloneAndMove (xPos:int, yPos:int):void {
			worldArray[xPos][yPos] = 0;
			worldArray[xPos + 1][yPos] = 1;
			worldArray[xPos][yPos + 1] = 1;
		}

		public function extendXAxis ():void {
			for (var tempcounter:int = 0; tempcounter < worldArray.length; tempcounter++) {
				worldArray[tempcounter].push (0);
			}
			render ();
		}

		public function extendYAxis ():void {
			var tempArray:Array = new Array(worldArray[0].length - 1);
			for (var tempcounter:int = 0; tempcounter < worldArray[0].length; tempcounter++) {
				tempArray[tempcounter] = 0;
			}
			worldArray.push (tempArray);
			render ();
		}
	}
}