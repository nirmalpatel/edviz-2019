from concept_formation.trestle import TrestleTree
from concept_formation.visualize import visualize

# These lines load up and use one of the example datasets included in the
# library if you don't have a readily available dataset to test. The rb_s_07
# dataset is similar to but not exactly the same as the one used to generate
# the figures in the paper.
from concept_formation.datasets import load_rb_s_07
from concept_formation.preprocessor import ObjectVariablizer

data = load_rb_s_07()

# As long as your data conforms to the instance representation:
# https://concept-formation.readthedocs.io/en/latest/instance_representation.html
# it can be basically anything.

# data = []

# This step is to make sure the component attributes of the instances are
# properly tagged as variable. See the instance representation link above for
# this.

# ov = ObjectVariablizer()
# data = ov.batch_transform(data)

# These three lines are the core of the process. They will fit the data and
# generate a visualization that will automatically open a browser to the view.
# If you want to embed the output in some other process, like a LearnSphere
# workflow, it would take a little more work but is easy in principle.
tree = TrestleTree()
tree.fit(data)
visualize(tree, "vizfiles")