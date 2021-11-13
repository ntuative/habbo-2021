package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureMannequinVisualization extends FurnitureVisualization implements IAvatarImageListener 
    {

        private static const AVATAR_IMAGE_SPRITE_TAG:String = "avatar_image";

        private static var _customPlaceholders:Dictionary;
        private static var _SafeStr_3314:int;

        private const MANNEQUIN_BODY:String = "hd-99999-99998";

        private var _SafeStr_1382:String;
        private var _SafeStr_1926:String;
        private var _SafeStr_1266:int;
        private var _needsUpdate:Boolean = false;
        private var _dynamicAssetName:String;
        private var _SafeStr_690:AvatarFurnitureVisualizationData;
        private var _disposed:Boolean = false;

        public function FurnitureMannequinVisualization()
        {
            _SafeStr_3314++;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        override public function dispose():void
        {
            if (!_disposed)
            {
                _SafeStr_690 = null;
                _disposed = true;
                if (((_dynamicAssetName) && (assetCollection)))
                {
                    assetCollection.disposeAsset(_dynamicAssetName);
                    _dynamicAssetName = null;
                };
                super.dispose();
                _SafeStr_3314--;
                if (((_SafeStr_3314 == 0) && (_customPlaceholders)))
                {
                    for each (var _local_1:IAvatarImage in _customPlaceholders)
                    {
                        _local_1.dispose();
                    };
                    _customPlaceholders = null;
                };
            };
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            _SafeStr_690 = (_arg_1 as AvatarFurnitureVisualizationData);
            super.initialize(_arg_1);
            return (true);
        }

        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            var _local_3:Boolean = super.updateObject(_arg_1, _arg_2);
            if (_local_3)
            {
                if (_SafeStr_1266 != _arg_1)
                {
                    _SafeStr_1266 = _arg_1;
                    addAvatarAsset();
                };
            };
            return (_local_3);
        }

        private function addAvatarAsset(_arg_1:Boolean=false):void
        {
            var _local_3:IAvatarImage;
            var _local_2:IAvatarImage;
            if (((!(isAvatarAssetReady())) || (_arg_1)))
            {
                _local_3 = _SafeStr_690.getAvatar(_SafeStr_1382, _SafeStr_1266, _SafeStr_1926, this);
                if (_local_3)
                {
                    if (_local_3.isPlaceholder())
                    {
                        _local_3.dispose();
                        _local_2 = getCustomPlaceholder(_SafeStr_1266);
                        _local_2.setDirection("full", direction);
                        assetCollection.addAsset(getAvatarAssetName(), _local_2.getImage("full", true), true);
                        _needsUpdate = true;
                        return;
                    };
                    _local_3.setDirection("full", direction);
                    if (_dynamicAssetName)
                    {
                        assetCollection.disposeAsset(_dynamicAssetName);
                    };
                    assetCollection.addAsset(getAvatarAssetName(), _local_3.getImage("full", true), true);
                    _dynamicAssetName = getAvatarAssetName();
                    _needsUpdate = true;
                    _local_3.dispose();
                };
            };
        }

        override public function getSpriteList():Array
        {
            var _local_1:IAvatarImage = _SafeStr_690.getAvatar(_SafeStr_1382, _SafeStr_1266, _SafeStr_1926, this);
            if (_local_1 == null)
            {
                return (super.getSpriteList());
            };
            _local_1.setDirection("full", direction);
            return (_local_1.getServerRenderData());
        }

        private function getCustomPlaceholder(_arg_1:int):IAvatarImage
        {
            if (!_customPlaceholders)
            {
                _customPlaceholders = new Dictionary();
            };
            var _local_2:IAvatarImage = _customPlaceholders[_arg_1];
            if (_local_2 == null)
            {
                _local_2 = _SafeStr_690.getAvatar("hd-99999-99998", _arg_1, null, null);
                _customPlaceholders[_arg_1] = _local_2;
            };
            return (_local_2);
        }

        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_3:IRoomObject;
            var _local_4:IRoomObjectModel;
            var _local_2:String;
            var _local_5:Boolean = super.updateModel(_arg_1);
            if (_local_5)
            {
                _local_3 = object;
                if (_local_3 != null)
                {
                    _local_4 = _local_3.getModel();
                    if (_local_4 != null)
                    {
                        _local_2 = _local_4.getString("furniture_mannequin_figure");
                        if (_local_2)
                        {
                            _SafeStr_1926 = _local_4.getString("furniture_mannequin_gender");
                            _SafeStr_1382 = ((_local_2 + ".") + "hd-99999-99998");
                            addAvatarAsset();
                        };
                    };
                };
            };
            if (!_local_5)
            {
                _local_5 = _needsUpdate;
            };
            _needsUpdate = false;
            return (_local_5);
        }

        private function isAvatarAssetReady():Boolean
        {
            return ((_SafeStr_1382) && (!(getAsset(getAvatarAssetName()) == null)));
        }

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            if ((((!(_SafeStr_1382 == null)) && (_local_3 == "avatar_image")) && (isAvatarAssetReady())))
            {
                return (getAvatarAssetName());
            };
            return (super.getSpriteAssetName(_arg_1, _arg_2));
        }

        private function getAvatarAssetName():String
        {
            var _local_1:IRoomObject = object;
            if (!_local_1)
            {
                return (null);
            };
            return ((((((("mannequin_" + _SafeStr_1382) + "_") + _SafeStr_1266) + "_") + direction) + "_") + _local_1.getId());
        }

        public function avatarImageReady(_arg_1:String):void
        {
            if (_arg_1 == _SafeStr_1382)
            {
                addAvatarAsset(true);
            };
        }

        override protected function getSpriteXOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:String = getSpriteTag(_arg_1, _arg_2, _arg_3);
            if (((_local_4 == "avatar_image") && (isAvatarAssetReady())))
            {
                return (-(getSprite(_arg_3).width) / 2);
            };
            return (super.getSpriteXOffset(_arg_1, _arg_2, _arg_3));
        }

        override protected function getSpriteYOffset(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:String = getSpriteTag(_arg_1, _arg_2, _arg_3);
            if (((_local_4 == "avatar_image") && (isAvatarAssetReady())))
            {
                return (-(getSprite(_arg_3).height));
            };
            return (super.getSpriteYOffset(_arg_1, _arg_2, _arg_3));
        }


    }
}

