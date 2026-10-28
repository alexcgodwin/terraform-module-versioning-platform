import sys
import unittest
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'scripts'))
from check_contracts import is_compatible

class CompatibilityTests(unittest.TestCase):
    def setUp(self):self.old={'inputs':{'service_name':'required'},'outputs':['service_id']}
    def test_optional_input_is_backward_compatible(self):
        new={'inputs':{'service_name':'required','owner':'optional'},'outputs':['service_id','owner']}
        self.assertTrue(is_compatible(self.old,new)[0])
    def test_new_mandatory_input_breaks_contract(self):
        new={'inputs':{'service_name':'required','owner':'required'},'outputs':['service_id']}
        self.assertIn('new_required_input:owner',is_compatible(self.old,new)[1])
    def test_removed_output_breaks_contract(self):
        new={'inputs':{'service_name':'required'},'outputs':[]}
        self.assertIn('removed_output:service_id',is_compatible(self.old,new)[1])
    def test_removed_input_breaks_contract(self):
        new={'inputs':{},'outputs':['service_id']}
        self.assertIn('removed_input:service_name',is_compatible(self.old,new)[1])

if __name__=='__main__':unittest.main()
