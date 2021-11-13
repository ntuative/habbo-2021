package com.sulake.habbo.room.object.visualization.data
{
    import __AS3__.vec.Vector;
    import com.sulake.habbo.room.object.visualization.furniture.FurnitureExternalImageVisualization;
    import flash.utils.setInterval;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class ExtraDataManager 
    {

        public static const STATUS_REJECTED:String = "REJECTED";
        private static const BATCH_MAX_QUERY_AMOUNT:int = 50;

        private static var instance:ExtraDataManager;

        private var inputVisualizationQueue:Vector.<FurnitureExternalImageVisualization> = new Vector.<FurnitureExternalImageVisualization>();
        private var outputVisualizationQueue:Vector.<FurnitureExternalImageVisualization> = new Vector.<FurnitureExternalImageVisualization>();

        public function ExtraDataManager()
        {
            setTimedBatchCheck();
        }

        private static function getInstance():ExtraDataManager
        {
            if (!instance)
            {
                instance = new ExtraDataManager();
            };
            return (instance);
        }

        public static function requestExtraDataUrl(_arg_1:FurnitureExternalImageVisualization):void
        {
            getInstance().inputVisualizationQueue.push(_arg_1);
        }

        public static function furnitureDisposed(_arg_1:FurnitureExternalImageVisualization):void
        {
            getInstance().removeFurniFromManager(_arg_1);
        }


        private function setTimedBatchCheck():void
        {
            setInterval(handleBatch, 200); //not popped
        }

        private function removeFurniFromManager(_arg_1:FurnitureExternalImageVisualization):void
        {
            if (inputVisualizationQueue.indexOf(_arg_1) != -1)
            {
                inputVisualizationQueue.splice(inputVisualizationQueue.indexOf(_arg_1), 1);
            };
            if (outputVisualizationQueue.indexOf(_arg_1) != -1)
            {
                outputVisualizationQueue.splice(outputVisualizationQueue.indexOf(_arg_1), 1);
            };
        }

        private function handleBatch():void
        {
            var _local_8:String;
            var _local_4:int;
            var _local_5:FurnitureExternalImageVisualization;
            var _local_7:String;
            if (inputVisualizationQueue.length == 0)
            {
                return;
            };
            var _local_2:Array = [];
            _local_4 = 0;
            while (_local_4 < 50)
            {
                if (inputVisualizationQueue.length > 0)
                {
                    _local_5 = inputVisualizationQueue.shift();
                    _local_7 = _local_5.getExternalImageUUID();
                    _local_2.push(_local_7);
                    _local_8 = _local_5.getExtraDataUrl();
                    outputVisualizationQueue.push(_local_5);
                };
                _local_4++;
            };
            if (_local_2.length == 0)
            {
                return;
            };
            var _local_1:URLRequest = new URLRequest();
            _local_1.method = "POST";
            _local_1.contentType = "application/json";
            var _local_6:String = JSON.stringify(_local_2);
            _local_1.data = _local_6;
            _local_1.url = _local_8;
            var _local_3:URLLoader = new URLLoader(_local_1);
            _local_3.dataFormat = "text";
            _local_3.addEventListener("complete", onExtraDataLoaded);
            _local_3.addEventListener("ioError", onExtraDataError);
        }

        private function onExtraDataLoaded(_arg_1:Event):void
        {
            var _local_2:Array;
            var _local_6:String;
            var _local_4:String = _arg_1.currentTarget.data;
            if (((_local_4) && (_local_4.length > 0)))
            {
                try
                {
                    _local_2 = (JSON.parse(_local_4) as Array);
                    for each (var _local_5:Object in _local_2)
                    {
                        _local_6 = _local_5.id;
                        for each (var _local_3:FurnitureExternalImageVisualization in outputVisualizationQueue)
                        {
                            if (_local_3.getExternalImageUUID() == _local_6)
                            {
                                if (((_local_5.status) && (_local_5.status == "REJECTED")))
                                {
                                    _local_3.onUrlFromExtraDataService("REJECTED");
                                }
                                else
                                {
                                    _local_3.onUrlFromExtraDataService(_local_5.url);
                                };
                                removeFurniFromManager(_local_3);
                            };
                        };
                    };
                }
                catch(error:Error)
                {
                    Logger.log("Failed to read JSON from ExtraData service");
                };
            };
        }

        private function onExtraDataError(_arg_1:IOErrorEvent):void
        {
            Logger.log(("Failed to load ExtraData batch " + _arg_1.toString()));
        }


    }
}

