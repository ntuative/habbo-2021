package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.core.assets.IAssetLibrary;

    public class SnowballVisualizationData implements IRoomObjectVisualizationData 
    {

        private var _assets:IAssetLibrary;


        public function dispose():void
        {
            _assets = null;
        }

        public function initialize(_arg_1:XML):Boolean
        {
            return (true);
        }

        public function set assets(_arg_1:IAssetLibrary):void
        {
            _assets = _arg_1;
        }

        public function get assets():IAssetLibrary
        {
            return (_assets);
        }


    }
}