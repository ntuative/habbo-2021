package com.sulake.habbo.avatar.alias
{
    import com.sulake.core.assets.AssetLibraryCollection;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.AvatarRenderManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.assets.IAsset;

    public class AssetAliasCollection 
    {

        private var _assets:AssetLibraryCollection;
        private var _aliases:Dictionary;
        private var _avatarRenderManager:AvatarRenderManager;
        private var _SafeStr_1247:Array;

        public function AssetAliasCollection(_arg_1:AvatarRenderManager, _arg_2:AssetLibraryCollection)
        {
            _avatarRenderManager = _arg_1;
            _aliases = new Dictionary();
            _assets = _arg_2;
            _SafeStr_1247 = [];
        }

        public function dispose():void
        {
            _assets = null;
            _aliases = null;
        }

        public function reset():void
        {
            init();
        }

        public function onAvatarAssetsLibraryReady(_arg_1:String):void
        {
            var _local_3:String;
            var _local_2:AssetAlias;
            var _local_4:IAssetLibrary = _assets.getAssetLibraryByPartialUrl((("/" + _arg_1) + ".swf"));
            if (_local_4)
            {
                for each (var _local_5:XML in _local_4.manifest..alias)
                {
                    _local_3 = String(_local_5.@name);
                    _local_2 = new AssetAlias(_local_5);
                    _aliases[_local_3] = _local_2;
                };
            };
        }

        public function init():void
        {
            var _local_4:String;
            var _local_2:AssetAlias;
            var _local_3:Array = _assets.getManifests();
            for each (var _local_1:XML in _local_3)
            {
                for each (var _local_5:XML in _local_1..alias)
                {
                    _local_4 = String(_local_5.@name);
                    _local_2 = new AssetAlias(_local_5);
                    _aliases[_local_4] = _local_2;
                };
            };
        }

        public function addAlias(_arg_1:String, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_6:XML = <alias name="" link="" fliph="0" flipv="0" />
            ;
            _local_6.@name = _arg_1;
            _local_6.@link = _arg_2;
            var _local_5:AssetAlias = new AssetAlias(_local_6);
            _aliases[_arg_1] = _local_5;
        }

        public function hasAlias(_arg_1:String):Boolean
        {
            var _local_2:AssetAlias = (_aliases[_arg_1] as AssetAlias);
            return (!(_local_2 == null));
        }

        public function getAssetName(_arg_1:String):String
        {
            var _local_4:AssetAlias;
            var _local_2:String = _arg_1;
            var _local_3:int = 5;
            while (((hasAlias(_local_2)) && (_local_3 >= 0)))
            {
                _local_4 = (_aliases[_local_2] as AssetAlias);
                _local_2 = _local_4.link;
                _local_3--;
            };
            return (_local_2);
        }

        public function getAssetByName(_arg_1:String):IAsset
        {
            _arg_1 = getAssetName(_arg_1);
            return (_assets.getAssetByName(_arg_1));
        }


    }
}

