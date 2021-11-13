package com.sulake.habbo.groups.badge
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.IAssetReceiver;
    import com.sulake.habbo.groups.HabboGroupsManager;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import com.sulake.habbo.communication.messages.incoming.users.BadgePartData;
    import com.sulake.core.assets.IResourceManager;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.communication.messages.incoming.users.GuildColorData;
    import flash.geom.Point;

    public class BadgeEditorPartItem implements IDisposable, IAssetReceiver 
    {

        public static var BASE_PART:int = 0;
        public static var LAYER_PART:int = 1;
        public static var IMAGE_WIDTH:Number = 39;
        public static var IMAGE_HEIGHT:Number = 39;
        public static var CELL_WIDTH:Number = 13;
        public static var CELL_HEIGHT:Number = 13;

        private var _SafeStr_825:HabboGroupsManager;
        private var _SafeStr_2610:BadgeSelectPartCtrl;
        private var _partIndex:int;
        private var _SafeStr_741:int;
        private var _SafeStr_2609:String;
        private var _disposed:Boolean;
        private var _fileName:String;
        private var _maskFileName:String;
        private var _SafeStr_1384:BitmapData;
        private var _mask:BitmapData;
        private var _composite:BitmapData;
        private var _SafeStr_1107:ColorTransform = new ColorTransform(1, 1, 1);
        private var _SafeStr_2611:Boolean = false;
        private var _isLoaded:Boolean = false;
        private var _SafeStr_2612:Boolean = false;

        public function BadgeEditorPartItem(_arg_1:HabboGroupsManager, _arg_2:BadgeSelectPartCtrl, _arg_3:int, _arg_4:int, _arg_5:BadgePartData=null)
        {
            _partIndex = _arg_3;
            _SafeStr_825 = _arg_1;
            _SafeStr_2610 = _arg_2;
            _SafeStr_741 = _arg_4;
            _SafeStr_2609 = _SafeStr_825.getProperty("image.library.badgepart.url");
            _composite = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
            if (_arg_5 == null)
            {
                _isLoaded = true;
                _SafeStr_2612 = true;
                _SafeStr_1384 = _SafeStr_825.getButtonImage("badge_part_empty");
            }
            else
            {
                _fileName = _arg_5.fileName.replace(".gif", "").replace(".png", "");
                _maskFileName = _arg_5.maskFileName.replace(".gif", "").replace(".png", "");
                _SafeStr_2611 = (_maskFileName.length > 0);
                _composite = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT);
                _fileName = (((_SafeStr_2609 + "badgepart_") + _fileName) + ".png");
                _maskFileName = (((_SafeStr_2609 + "badgepart_") + _maskFileName) + ".png");
                _SafeStr_825.windowManager.resourceManager.retrieveAsset(_fileName, this);
                _SafeStr_825.windowManager.resourceManager.retrieveAsset(_maskFileName, this);
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get partIndex():int
        {
            return (_partIndex);
        }

        public function receiveAsset(_arg_1:IAsset, _arg_2:String):void
        {
            var _local_3:IResourceManager = _SafeStr_825.windowManager.resourceManager;
            if (_local_3.isSameAsset(_fileName, _arg_2))
            {
                _SafeStr_1384 = (_arg_1.content as BitmapData);
            };
            if (_local_3.isSameAsset(_maskFileName, _arg_2))
            {
                _mask = (_arg_1.content as BitmapData);
            };
            checkIsImageLoaded();
        }

        public function dispose():void
        {
            if (!disposed)
            {
                if (_SafeStr_1384)
                {
                    _SafeStr_1384.dispose();
                    _SafeStr_1384 = null;
                };
                if (_mask)
                {
                    _mask.dispose();
                    _mask = null;
                };
                if (_composite)
                {
                    _composite.dispose();
                    _composite = null;
                };
                _fileName = null;
                _maskFileName = null;
                _SafeStr_1107 = null;
                _SafeStr_2610 = null;
                _SafeStr_825 = null;
                _disposed = true;
            };
        }

        private function checkIsImageLoaded():void
        {
            if (_SafeStr_1384 == null)
            {
                return;
            };
            if (((_SafeStr_2611) && (_mask == null)))
            {
                return;
            };
            _isLoaded = true;
            if (_SafeStr_741 == BASE_PART)
            {
                _SafeStr_2610.onBaseImageLoaded(this);
            }
            else
            {
                _SafeStr_2610.onLayerImageLoaded(this);
            };
        }

        public function getComposite(_arg_1:BadgeLayerOptions):BitmapData
        {
            if (!_isLoaded)
            {
                return (null);
            };
            if (_SafeStr_2612)
            {
                return (_SafeStr_1384);
            };
            var _local_2:GuildColorData = (_SafeStr_825.guildEditorData.badgeColors[_arg_1.colorIndex] as GuildColorData);
            _SafeStr_1107.redMultiplier = (_local_2.red / 0xFF);
            _SafeStr_1107.greenMultiplier = (_local_2.green / 0xFF);
            _SafeStr_1107.blueMultiplier = (_local_2.blue / 0xFF);
            var _local_3:Point = getPosition(_arg_1);
            _composite.dispose();
            _composite = new BitmapData(IMAGE_WIDTH, IMAGE_HEIGHT, true, 0);
            _composite.copyPixels(_SafeStr_1384, _SafeStr_1384.rect, _local_3);
            _composite.colorTransform(_composite.rect, _SafeStr_1107);
            if (_SafeStr_2611)
            {
                _composite.copyPixels(_mask, _mask.rect, _local_3, null, null, true);
            };
            return (_composite);
        }

        private function getPosition(_arg_1:BadgeLayerOptions):Point
        {
            var _local_2:Number = (((CELL_WIDTH * _arg_1.gridX) + (CELL_WIDTH / 2)) - (_SafeStr_1384.width / 2));
            var _local_3:Number = (((CELL_HEIGHT * _arg_1.gridY) + (CELL_HEIGHT / 2)) - (_SafeStr_1384.height / 2));
            if (_local_2 < 0)
            {
                _local_2 = 0;
            };
            if ((_local_2 + _SafeStr_1384.width) > IMAGE_WIDTH)
            {
                _local_2 = (IMAGE_WIDTH - _SafeStr_1384.width);
            };
            if (_local_3 < 0)
            {
                _local_3 = 0;
            };
            if ((_local_3 + _SafeStr_1384.height) > IMAGE_HEIGHT)
            {
                _local_3 = (IMAGE_HEIGHT - _SafeStr_1384.height);
            };
            return (new Point(Math.floor(_local_2), Math.floor(_local_3)));
        }


    }
}

