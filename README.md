# NFLBDB2023
NFL Big Data Bowl 2023

Link to paper: https://www.kaggle.com/code/benjenkins96/causal-impact-of-offensive-linemen-on-pass-plays

# Introduction
We present CLIPP (CausaL Impact of offensive linemen on Pass Plays), a new approach for analyzing the performance of offensive linemen. We apply causal inference methods using NFL player tracking data to quantify the contributions of offensive linemen. Causality is often confused with correlation; simply observing a correlation between two variables or events is not sufficient to imply causality. Causal inference methods are widely used in many applications where randomized control tests are not possible. Here we apply causal inference for the first time to study offensive line performance. Causality allows us to make informed decisions and predictions about the effect of actions of the offensive line.

CLIPP is validated by external rankings and is superior to the correlation-based methods tested. In contrast to previous metrics, such as rush yards over expected, CLIPP is designed to answer causal questions. This is an important distinction, as previous approaches that rely on supervised learning techniques cannot identify cause-and-effect relationships. These methods make faulty assumptions about the data and often attribute a player's contribution to the residual rather than accurately measuring the cause and effect of the player's actions. CLIPP avoids these pitfalls and provides a more robust and accurate assessment of offensive line performance.

CLIPP uses advanced causal inference methods to assign credit to players using player tracking data and contextual information such as yards to go and down. Our extensive testing shows that our results are accurate and reliable. The use of causal inference provides valuable new insights into offensive line performance. We hope this begins the transition from reliance on prediction and correlation towards a focus on cause and effect.

# Methodology

Doubly robust causal inference is a powerful statistical technique that provides an accurate estimate of the causal effect of an action, such as a pass rush in football, on the outcome of a play. This approach combines two statistical models, making it highly effective in accounting for individual differences between players and plays that can greatly affect the outcome of a football play.

Our doubly robust model uses gradient boosting models, which can handle high-dimensional and non-linear data, making them ideal for analyzing complex interactions in football plays. We use these models to estimate the conditional average treatment effect (CATE) and compute CLIPP, which helps us understand how a pass rush affects the outcome of a football play while accounting for differences between players and plays.
                                              𝐶𝐴𝑇𝐸=𝐸[𝑌𝑖|𝑋𝑖=𝑥,𝑇𝑖=1]−𝐸[𝑌𝑖|𝑋𝑖=𝑥,𝑇𝑖=0]

To calculate the CATE, we estimate the expected result of the pass play given individual features (Xi) and given whether the lineman allowed the QB to be pressured, hit, or sacked (Ti=1) or not (Ti=0). The CATE is the difference between these two outcomes in expectation and is always negative because QB pressure, hit, or a sack allowed by offensive linemen decreases the probability of a completed pass.

CLIPP estimates the effect of each offensive lineman on the probability of a pass completion every tenth of a second. If the propensity score model predicts that the lineman has a greater than 50% chance of allowing pressure, a QB hit, or a QB sack, then CLIPP is the conditional average treatment effect. If there is less than a 50% chance, CLIPP is the difference between the expected result of no pressure, hit, or sack allowed (Ti=0) and the expected result of pressure, hit, or sack allowed (Ti=1). We only consider the interval between the snap and the pass. The probabilities are then averaged to provide a play-level summary.

Ensuring the robustness and accuracy of the causal estimate is crucial in causal inference. We use several refutation tests to assess whether the assumptions made to identify the causal effect are reasonable. These tests allow us to verify that our estimator is reliable and trustworthy and are discussed in the Model Evaluation and Refutation Tests section. Overall, doubly robust causal inference is a valuable tool for understanding the impact of specific actions on the outcome of complex systems like football games.
