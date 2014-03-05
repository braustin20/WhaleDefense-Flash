package com.game
{
	public class EmbeddedAssets
	{
		
		//-----Sprite Sheets-----
		[Embed(source="../assets/buttons.png")]
		public static const buttons:Class;
		
		[Embed(source="../assets/buttons.xml",mimeType="application/octet-stream")]
		public static const buttonsXml:Class;
		
		[Embed(source="../assets/basicWhale.xml",mimeType="application/octet-stream")]
		public static const basicWhaleXml:Class;
		[Embed(source="../assets/basicWhale.png")]
		public static const basicWhale:Class;
		
		[Embed(source="../assets/pauseBackground.png")]
		public static const pauseBackground:Class;
		
		[Embed(source="../assets/level1.xml",mimeType="application/octet-stream")]
		public static const Level1Xml:Class;
		[Embed(source="../assets/level1.png")]
		public static const level1:Class;
		
		[Embed(source="../assets/playerObjects_basic.xml",mimeType="application/octet-stream")]
		public static const BasicObjectsXml:Class;
		[Embed(source="../assets/playerObjects_basic.png")]
		public static const playerObjects_basic:Class;
		
		//-----Load single images-----
		[Embed(source="../assets/mainMenuBackground.png")]
		public static const mainMenuBackground:Class;
		
		[Embed(source="../assets/wavesBackground.png")]
		public static const wavesBackground:Class;
		
		//-----Audio------
		[Embed(source="../assets/audio/happyArcade.mp3")]
		public static const happyArcade:Class;
		
		[Embed(source="../assets/audio/frozenLoop.mp3")]
		public static const frozenLoop:Class;
		
		[Embed(source="../assets/audio/boom9.mp3")]
		public static const boom9:Class;
		
		
		public function EmbeddedAssets()
		{
			
		}
	}
}