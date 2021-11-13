package com.sulake.habbo.freeflowchat
{
    import com.sulake.core.runtime.IDisposable;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import com.sulake.habbo.freeflowchat.viewer.ChatFlowViewer;
    import com.sulake.habbo.freeflowchat.history.visualization.ChatHistoryTray;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;

    public class ChatViewController implements IDisposable 
    {

        private var _rootDisplayObject:DisplayObjectContainer;
        private var _SafeStr_660:Stage;
        private var _SafeStr_659:HabboFreeFlowChat;
        private var _SafeStr_2223:ChatFlowViewer;
        private var _pulldown:ChatHistoryTray;
        private var _flowViewerDisplayObject:DisplayObject;
        private var _pulldownDisplayObject:DisplayObject;

        public function ChatViewController(_arg_1:HabboFreeFlowChat, _arg_2:ChatFlowViewer, _arg_3:ChatHistoryTray)
        {
            _SafeStr_659 = _arg_1;
            _SafeStr_2223 = _arg_2;
            _pulldown = _arg_3;
            _flowViewerDisplayObject = _SafeStr_2223.rootDisplayObject;
            _pulldownDisplayObject = _pulldown.rootDisplayObject;
            _rootDisplayObject = new Sprite();
            _rootDisplayObject.addChild(_flowViewerDisplayObject);
            _rootDisplayObject.addChild(_pulldownDisplayObject);
            _rootDisplayObject.addEventListener("addedToStage", onAddedToStage);
        }

        public function dispose():void
        {
            if (_rootDisplayObject)
            {
                _SafeStr_659.removeUpdateReceiver(_pulldown);
                if (_SafeStr_660)
                {
                    _SafeStr_660.removeEventListener("resize", onStageResized);
                };
                _rootDisplayObject.removeChild(_pulldownDisplayObject);
                _rootDisplayObject.removeChild(_flowViewerDisplayObject);
                _rootDisplayObject.removeEventListener("addedToStage", onAddedToStage);
                _rootDisplayObject = null;
                _pulldownDisplayObject = null;
                _flowViewerDisplayObject = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_rootDisplayObject == null);
        }

        public function get rootDisplayObject():DisplayObject
        {
            return (_rootDisplayObject);
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            _SafeStr_660 = _rootDisplayObject.stage;
            _SafeStr_660.addEventListener("resize", onStageResized);
            _pulldown.resize(_SafeStr_660.stageWidth, _SafeStr_660.stageHeight);
            _SafeStr_659.registerUpdateReceiver(_pulldown, 200);
        }

        private function onStageResized(_arg_1:Event):void
        {
            _pulldown.resize(_SafeStr_660.stageWidth, _SafeStr_660.stageHeight);
            _SafeStr_2223.resize(_SafeStr_660.stageWidth, _SafeStr_660.stageHeight);
        }


    }
}

