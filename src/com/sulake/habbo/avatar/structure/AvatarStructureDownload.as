package com.sulake.habbo.avatar.structure
{
    import com.sulake.core.runtime.events.EventDispatcherWrapper;
    import flash.net.URLRequest;
    import com.sulake.core.assets.AssetLoaderStruct;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.Core;
    import flash.events.Event;
    import com.sulake.habbo.utils.HabboWebTools;

    public class AvatarStructureDownload extends EventDispatcherWrapper 
    {

        public static const STRUCTURE_DONE:String = "AVATAR_STRUCTURE_DONE";

        private var _SafeStr_1349:IStructureData;

        public function AvatarStructureDownload(_arg_1:IAssetLibrary, _arg_2:String, _arg_3:IStructureData)
        {
            _SafeStr_1349 = _arg_3;
            if (_arg_1.hasAsset(_arg_2))
            {
                Logger.log(("[AvatarStructureDownload] reload data for url: " + _arg_2));
            };
            var _local_4:URLRequest = new URLRequest(_arg_2);
            var _local_5:AssetLoaderStruct = _arg_1.loadAssetFromFile(_arg_2, _local_4, "text/plain");
            _local_5.addEventListener("AssetLoaderEventComplete", onDataComplete);
            _local_5.addEventListener("AssetLoaderEventError", onDataFailed);
        }

        private function onDataComplete(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_4:XML;
            var _local_3:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            if (((_local_3 == null) || (_local_3.assetLoader == null)))
            {
                return;
            };
            try
            {
                _local_2 = (_local_3.assetLoader.content as String);
                if (((_local_2 == null) || (_local_2.length == 0)))
                {
                    Core.error((((("Could not load avatar structure, got empty data from URL " + _local_3.assetLoader.url) + " data length = ") + _local_2.length) + "."), false, 1);
                };
                _local_4 = new XML(_local_2);
            }
            catch(e:Error)
            {
                Logger.log(("[AvatarStructureDownload] Error: " + e.message));
                return;
            };
            if (_local_4 == null)
            {
                Logger.log((("[AvatarStructureDownload] XML error: " + _local_3) + " not valid XML"));
                return;
            };
            _SafeStr_1349.appendXML(_local_4);
            dispatchEvent(new Event("AVATAR_STRUCTURE_DONE"));
        }

        private function onDataFailed(_arg_1:Event):void
        {
            var _local_2:AssetLoaderStruct = (_arg_1.target as AssetLoaderStruct);
            var _local_3:String = "";
            if (((!(_local_2 == null)) && (!(_local_2.assetLoader == null))))
            {
                _local_3 = _local_2.assetLoader.url;
            };
            HabboWebTools.logEventLog(("figurepartlist download error " + _local_3));
            Core.error(("Could not load avatar structure. Failed to get data from URL " + _local_3), true, 1);
        }


    }
}

