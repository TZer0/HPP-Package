package substate;

import h2d.Flow;
import h2d.Text;
import h2d.Tile;
import h2d.col.Bounds;
import hpp.heaps.Base2dStage.StagePosition;
import hpp.heaps.Base2dStage.StageScaleMode;
import hpp.heaps.Base2dSubState;
import hpp.heaps.ui.PlaceHolder;
import hxd.res.FontBuilder;
import view.Checkbox;

/**
 * ...
 * @author Krisztian Somoracz
 */
class StageSample extends Base2dSubState
{
	var content:Flow;

	override function build()
	{
		super.build();

		content = new Flow(container);
		content.verticalSpacing = 20;
		content.isVertical = true;

		createStageScalePanel();
		createStagePositionPanel();
	}

	function createStageScalePanel()
	{
		var subContent = new Flow(content);
		subContent.verticalSpacing = 10;
		subContent.padding = 10;
		subContent.minWidth = 660;
		subContent.horizontalAlign = FlowAlign.Left;
		subContent.isVertical = true;
		subContent.backgroundTile = Tile.fromColor(0x000000, 1, 1, .4);

		var label:Text = new Text(FontBuilder.getFont("Verdana", 12), subContent);
		label.text = "Change stage scale mode";
		new PlaceHolder(subContent, 10, 15);

		var firstCheckbox:Checkbox = new Checkbox(
			subContent,
			"NO_SCALE",
			function() { stage.stageScaleMode = StageScaleMode.NO_SCALE; }
		);
		firstCheckbox.isSelected = true;

		firstCheckbox.linkToButton(new Checkbox(
			subContent,
			"SHOW_ALL",
			function() { stage.stageScaleMode = StageScaleMode.SHOW_ALL; }
		));

		firstCheckbox.linkToButton(new Checkbox(
			subContent,
			"EXACT_FIT",
			function() { stage.stageScaleMode = StageScaleMode.EXACT_FIT; }
		));
	}

	function createStagePositionPanel()
	{
		var subContent = new Flow(content);
		subContent.verticalSpacing = 10;
		subContent.padding = 10;
		subContent.minWidth = 660;
		subContent.horizontalAlign = FlowAlign.Left;
		subContent.isVertical = true;
		subContent.backgroundTile = Tile.fromColor(0x000000, 1, 1, .4);

		var label:Text = new Text(FontBuilder.getFont("Verdana", 12), subContent);
		label.text = "Change stage position (Only for stage 'Show all' mode)";
		new PlaceHolder(subContent, 10, 15);

		var grid:Flow = new Flow(subContent);
		grid.isVertical = false;
		grid.maxWidth = subContent.minWidth;
		grid.multiline = true;
		grid.horizontalSpacing = 20;
		grid.verticalSpacing = 10;

		var stagePositions:Array<StagePosition> = [
			StagePosition.LEFT_TOP, StagePosition.CENTER_TOP, StagePosition.RIGHT_TOP,
			StagePosition.LEFT_MIDDLE, StagePosition.CENTER_MIDDLE, StagePosition.RIGHT_MIDDLE,
			StagePosition.LEFT_BOTTOM, StagePosition.CENTER_BOTTOM, StagePosition.RIGHT_BOTTOM
		];

		var firstCheckbox:Checkbox = null;
		for (position in stagePositions)
		{
			var checkbox = new Checkbox(
				grid,
				position.getName(),
				function() { stage.stagePosition = position; }
			);

			if (firstCheckbox == null)
			{
				firstCheckbox = checkbox;
				firstCheckbox.isSelected = true;
			}
			else
			{
				firstCheckbox.linkToButton(checkbox);
			}
		}
	}

	override public function onOpen()
	{
		super.onOpen();

		rePosition();
	}

	override public function onStageResize(width:Float, height:Float)
	{
		rePosition();
	}

	function rePosition()
	{
		var size:Bounds = content.getSize();

		content.x = stage.width / 2 - size.width / 2;
		content.y = stage.height / 2 - size.height / 2;
	}
}