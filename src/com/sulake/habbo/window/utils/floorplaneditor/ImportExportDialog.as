package com.sulake.habbo.window.utils.floorplaneditor
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.communication.messages.outgoing.room.layout.UpdateFloorPropertiesMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;

    public class ImportExportDialog 
    {

        private var _bcFloorPlanEditor:BCFloorPlanEditor;
        private var _layout:XML;
        private var _window:IFrameWindow = null;

        public function ImportExportDialog(_arg_1:BCFloorPlanEditor, _arg_2:XML)
        {
            _bcFloorPlanEditor = _arg_1;
            _layout = _arg_2;
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_window == null)
            {
                _window = IFrameWindow(_bcFloorPlanEditor.windowManager.buildFromXML(_layout));
                _window.center();
                _window.procedure = windowProcedure;
            };
            if (_arg_1)
            {
                _window.visible = true;
                _window.findChildByName("data").caption = _bcFloorPlanEditor.floorPlanCache.getData();
                if (((_bcFloorPlanEditor.bcSecondsLeft > 0) || (_bcFloorPlanEditor.windowManager.sessionDataManager.hasSecurity(4))))
                {
                    _window.findChildByName("save").enable();
                }
                else
                {
                    _window.findChildByName("save").disable();
                };
                _window.activate();
            }
            else
            {
                _window.visible = false;
            };
        }

        public function get visible():Boolean
        {
            if (!_window)
            {
                return (false);
            };
            return (_window.visible);
        }

        private function windowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type == "WME_CLICK")
            {
                switch (_arg_2.name)
                {
                    case "header_button_close":
                        visible = false;
                        return;
                    case "revert":
                        _window.findChildByName("data").caption = _bcFloorPlanEditor.lastReceivedFloorPlan;
                        return;
                    case "save":
                        _bcFloorPlanEditor.windowManager.communication.connection.send(new UpdateFloorPropertiesMessageComposer(_window.findChildByName("data").caption, _bcFloorPlanEditor.floorPlanCache.entryPoint.x, _bcFloorPlanEditor.floorPlanCache.entryPoint.y, _bcFloorPlanEditor.floorPlanCache.entryPointDir, BCFloorPlanEditor.getThicknessSettingBySelectionIndex(_bcFloorPlanEditor.wallThickness), BCFloorPlanEditor.getThicknessSettingBySelectionIndex(_bcFloorPlanEditor.floorThickness)));
                        return;
                };
            };
        }


    }
}