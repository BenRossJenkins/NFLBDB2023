# NFLBDB2023
NFL Big Data Bowl 2023

Link to paper: https://www.kaggle.com/code/benjenkins96/causal-impact-of-offensive-linemen-on-pass-plays

# Introduction
We present CLIPP (CausaL Impact of offensive linemen on Pass Plays), a new approach for analyzing the performance of offensive linemen. We apply causal inference methods using NFL player tracking data to quantify the contributions of offensive linemen. Causality is often confused with correlation; simply observing a correlation between two variables or events is not sufficient to imply causality. Causal inference methods are widely used in many applications where randomized control tests are not possible. Here we apply causal inference for the first time to study offensive line performance. Causality allows us to make informed decisions and predictions about the effect of actions of the offensive line.

CLIPP is validated by external rankings and is superior to the correlation-based methods tested. In contrast to previous metrics, such as rush yards over expected, CLIPP is designed to answer causal questions. This is an important distinction, as previous approaches that rely on supervised learning techniques cannot identify cause-and-effect relationships. These methods make faulty assumptions about the data and often attribute a player's contribution to the residual rather than accurately measuring the cause and effect of the player's actions. CLIPP avoids these pitfalls and provides a more robust and accurate assessment of offensive line performance.

CLIPP uses advanced causal inference methods to assign credit to players using player tracking data and contextual information such as yards to go and down. Our extensive testing shows that our results are accurate and reliable. The use of causal inference provides valuable new insights into offensive line performance. We hope this begins the transition from reliance on prediction and correlation towards a focus on cause and effect.
