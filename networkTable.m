function [count, accuracy, label_counts, time] = predict_label(index, test, network, classNames)
    % Find the correct labels
    subds = subset(test, find(test.Labels == classNames(index, 1)));
    % augment them for the network input
    augsubds = augmentedImageDatastore(network.Layers(1).InputSize(1:2), subds);
    
    % Predict
    tic
    net_scores = minibatchpredict(network, augsubds);
    time = toc;
    pred_test = scores2label(net_scores, classNames);
    
    % Find total accuracy
    count = size(subds.Labels, 1);
    test_labels = subds.Labels;
    accuracy = mean(pred_test == test_labels);
    
    % Count of each label found
    label_counts = countcats(pred_test);
end

function T = createTable(network, test)
    classNames = categories(test.Labels);
    Label = cell(size(classNames, 1), 1);
    Total = zeros(size(classNames, 1), 1);
    Accuracy = zeros(size(classNames, 1), 1);
    Time = zeros(size(classNames, 1), 1);
    Time_On_Average = zeros(size(classNames, 1), 1);
    Most_Common_Mislabel = cell(size(classNames, 1), 1);
    Count_of_Common_Misslabel = zeros(size(classNames, 1), 1);
    % Label, count, accuracy, time_to_predict, time on average, most common
    % mistake, common mistake number of times
    for i = 1:size(classNames, 1)
        [count, accuracy, label_counts, time] = predict_label(i, test, ...
            network, classNames);
        Label(i, 1) = classNames(i, 1);
        Total(i, 1) = count;
        Accuracy(i, 1) = accuracy;
        Time(i, 1) = time;
        Time_On_Average(i, 1) = time/count;
        [B,I] = maxk(label_counts, 2);
        Most_Common_Mislabel(i, 1) = classNames(I(2, 1), 1);
        Count_of_Common_Misslabel(i, 1) = B(2, 1);
    end

    T = table(Label, Total, Accuracy, Time, Time_On_Average, ...
        Most_Common_Mislabel, Count_of_Common_Misslabel);
end

%%% Where the code starts
% Load all the data needed to make the table

% Give it your test dataset
load("test.mat");

% give it the network 
% TODO Network goes here
load("alex_net.mat");


% Create table of values
T = createTable(net, test);

