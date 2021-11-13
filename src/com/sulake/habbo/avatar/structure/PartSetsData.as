package com.sulake.habbo.avatar.structure
{
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.structure.parts.PartDefinition;
    import com.sulake.habbo.avatar.structure.parts.ActivePartSet;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.structure.parts.*;

    public class PartSetsData implements IStructureData 
    {

        private var _parts:Dictionary;
        private var _activePartSets:Dictionary;

        public function PartSetsData()
        {
            _parts = new Dictionary();
            _activePartSets = new Dictionary();
        }

        public function parse(_arg_1:XML):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            for each (var _local_3:XML in _arg_1.partSet[0].part)
            {
                _parts[String(_local_3.@["set-type"])] = new PartDefinition(_local_3);
            };
            for each (var _local_2:XML in _arg_1.activePartSet)
            {
                _activePartSets[String(_local_2.@id)] = new ActivePartSet(_local_2);
            };
            return (true);
        }

        public function appendXML(_arg_1:XML):Boolean
        {
            if (_arg_1 == null)
            {
                return (false);
            };
            for each (var _local_3:XML in _arg_1.partSet[0].part)
            {
                _parts[String(_local_3.@["set-type"])] = new PartDefinition(_local_3);
            };
            for each (var _local_2:XML in _arg_1.activePartSet)
            {
                _activePartSets[String(_local_2.@id)] = new ActivePartSet(_local_2);
            };
            return (false);
        }

        public function getActiveParts(_arg_1:IActionDefinition):Array
        {
            var _local_2:ActivePartSet = _activePartSets[_arg_1.activePartSet];
            if (_local_2 != null)
            {
                return (_local_2.parts);
            };
            return ([]);
        }

        public function getPartDefinition(_arg_1:String):PartDefinition
        {
            return (_parts[_arg_1] as PartDefinition);
        }

        public function addPartDefinition(_arg_1:XML):PartDefinition
        {
            var _local_2:String = String(_arg_1.@["set-type"]);
            if (_parts[_local_2] == null)
            {
                _parts[_local_2] = new PartDefinition(_arg_1);
            };
            return (_parts[_local_2]);
        }

        public function get parts():Dictionary
        {
            return (_parts);
        }

        public function get activePartSets():Dictionary
        {
            return (_activePartSets);
        }

        public function getActivePartSet(_arg_1:ActionDefinition):ActivePartSet
        {
            return (_activePartSets[_arg_1.activePartSet] as ActivePartSet);
        }


    }
}